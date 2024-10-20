defmodule NaagmWeb.RSVPForm do
  alias Naagm.Guests
  alias Naagm.Guests.Guest
  use NaagmWeb, :live_component

  @is_coming_prefix "is-coming"

  defp make_is_coming_map(params) do
    params
    |> Enum.filter(fn {key, _} -> String.contains?(key, @is_coming_prefix) end)
    |> Enum.reduce(
      %{},
      fn {key, val}, acc -> Map.put(acc, extract_number(key), val == "true") end
    )
  end

  defp assign_data(socket, params, is_coming_map) do
    changeset = Guest.changeset(socket.assigns.guest, params, is_coming_map)

    form =
      case params do
        _ when map_size(params) == 0 -> to_form(changeset)
        _ -> to_form(changeset, action: :validate)
      end

    socket
    |> assign(:form, form)
    |> assign(:parsed_party, Ecto.Changeset.get_field(changeset, :parsed_party, []))
  end

  defp extract_number(s) do
    Regex.run(~r/\d+/, s) |> List.first() |> String.to_integer()
  end

  defp with_member_ids(parsed_party) do
    parsed_party
    |> Enum.with_index()
    |> Enum.map(fn {member, idx} -> {member, "member-#{idx}"} end)
  end

  defp make_is_coming_radio_name(member_id), do: "guest[#{member_id}-#{@is_coming_prefix}]"

  @impl Phoenix.LiveComponent
  def handle_event("save", %{"guest" => guest_params}, socket) do
    is_coming_map = make_is_coming_map(guest_params)
    create? = socket.assigns.action == :create

    save_result =
      if create? do
        Guests.create_guest(guest_params, is_coming_map)
      else
        Guests.update_guest(socket.assigns.guest, guest_params, is_coming_map)
      end

    socket =
      case(save_result) do
        {:ok, guest} ->
          push_navigate(socket, to: ~p"/rsvp/#{guest.uuid}")

        {:error, changeset} ->
          assign(socket, :form, to_form(changeset))
      end

    {:noreply, socket}
  end

  @impl Phoenix.LiveComponent
  def handle_event("validate", %{"guest" => guest_params}, socket) do
    {:noreply, assign_data(socket, guest_params, make_is_coming_map(guest_params))}
  end

  @impl Phoenix.LiveComponent
  def update(assigns, socket) do
    party_members = assigns.guest.parsed_party

    is_coming_map =
      Enum.reduce(
        Enum.with_index(party_members),
        %{},
        fn {member, index}, acc -> Map.put(acc, index, member.is_coming) end
      )

    {
      :ok,
      socket
      |> assign(assigns)
      |> assign_data(%{}, is_coming_map)
    }
  end

  @impl Phoenix.LiveComponent
  def render(assigns) do
    ~H"""
    <div>
      <.simple_form
        for={@form}
        phx-change="validate"
        phx-submit="save"
        class="rsvp-form"
        phx-target={@myself}
      >
        <section>
          <h3>Who is coming or not?</h3>
          <.input
            label="You are welcome to bring your family or guest. Please enter the first and last name of everyone in your party (comma or newline separated)"
            placeholder="Anna Thompson, Nicolas Knoebber"
            rows="3"
            type="textarea"
            phx-debounce="20"
            field={@form[:raw_party_string]}
          />
          <ol class="parsed-party">
            <li :for={{member, member_id} <- with_member_ids(@parsed_party)}>
              <strong><%= member.full_name %></strong>:
              <span :for={
                {label, input_id, value, checked?} <- [
                  {"Yes", "#{member_id}-yes", "true", member.is_coming},
                  {"No", "#{member_id}-no", "false", member.is_coming === false}
                ]
              }>
                <label for={input_id}><%= label %></label>
                <input
                  checked={checked?}
                  type="radio"
                  name={make_is_coming_radio_name(member_id)}
                  id={input_id}
                  value={value}
                />
              </span>
            </li>
          </ol>
        </section>
        <section>
          <h3>Preferences (optional)</h3>
          <.input label="Food Restriction?" field={@form[:food_restriction]} />
          <.input
            label="Are you interested in camping on-site? More info to come."
            field={@form[:housing_preference]}
          />
          <.input label="Questions and Comments?" type="textarea" field={@form[:notes]} />
        </section>
        <.button>
          Submit
        </.button>
      </.simple_form>
    </div>
    """
  end
end
