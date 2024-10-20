defmodule NaagmWeb.RSVPLive do
  alias Naagm.Guests
  alias Naagm.Guests.Guest
  use NaagmWeb, :live_view

  @is_coming_prefix "is-coming"

  defp make_is_coming_map(params) do
    params
    |> Enum.filter(fn {key, _} -> String.contains?(key, @is_coming_prefix) end)
    |> Enum.reduce(
      %{},
      fn {key, val}, acc -> Map.put(acc, extract_number(key), val == "true") end
    )
  end

  defp assign_data(socket, params \\ %{}) do
    changeset = Guest.changeset(%Guest{}, params, make_is_coming_map(params))

    form =
      case params do
        _ when map_size(params) == 0 -> to_form(changeset)
        _ -> to_form(changeset, action: :validate)
      end

    socket
    |> assign(:form, form)
    |> assign(:parsed_party, Ecto.Changeset.get_field(changeset, :parsed_party, []))
  end

  @impl Phoenix.LiveView
  def mount(_params, _session, socket) do
    {:ok, assign_data(socket)}
  end

  @impl Phoenix.LiveView
  def handle_event("create", %{"guest" => guest_params}, socket) do
    socket =
      case(Guests.create_guest(guest_params, make_is_coming_map(guest_params))) do
        {:ok, guest} ->
          socket
          |> push_navigate(to: ~p"/rsvp/#{guest.uuid}")

        {:error, changeset} ->
          assign(socket, :form, to_form(changeset))
      end

    {:noreply, socket}
  end

  @impl Phoenix.LiveView
  def handle_event("validate", %{"guest" => guest_params}, socket) do
    {:noreply, assign_data(socket, guest_params)}
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

  @impl Phoenix.LiveView
  def render(assigns) do
    ~H"""
    <div class="content">
      <.simple_form for={@form} phx-change="validate" phx-submit="create" class="rsvp-form">
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
          <.input label="Housing Preference?" field={@form[:housing_preference]} />
        </section>
        <.button>
          Submit
        </.button>
      </.simple_form>
    </div>
    """
  end
end
