defmodule NaagmWeb.ShowRSVPLive do
  alias Naagm.Guests
  use NaagmWeb, :live_view

  @impl Phoenix.LiveView
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl Phoenix.LiveView
  def handle_params(%{"uuid" => uuid}, _, socket) do
    guest = Guests.get_guest_by_uuid(uuid)

    guest =
      if is_nil(guest) do
        nil
      else
        Map.put(
          guest,
          :raw_party_string,
          guest.parsed_party
          |> Enum.map(& &1.full_name)
          |> Enum.join(", ")
        )
      end

    {:noreply, socket |> assign(:guest, guest)}
  end

  @impl Phoenix.LiveView
  def handle_event("update", %{"guest" => _guest_params}, socket) do
    {:noreply, socket}
  end

  @impl Phoenix.LiveView
  def handle_event("validate", %{"guest" => _guest_params}, socket) do
    {:noreply, socket}
  end

  @impl Phoenix.LiveView
  def render(assigns) do
    ~H"""
    <div class="content">
      <h1>
        <%= if @live_action == :show do %>
          Thank you for RSVPing!
        <% else %>
          Update RSVP
        <% end %>
      </h1>

      <.live_component
        :if={@guest != nil and @live_action == :edit}
        guest={@guest}
        module={NaagmWeb.RSVPForm}
        initial_params={}
        id="rsvp-create-form"
        action={@live_action}
      />
      <section :if={@guest != nil and @live_action == :show} class="rsvp-response">
        <div>
          Party:
          <ol>
            <li :for={member <- @guest.parsed_party}>
              <span><%= member.full_name %> -</span> <span :if={member.is_coming}>yes</span>
              <span :if={not member.is_coming}>no</span>
            </li>
          </ol>
        </div>
        <div :if={@guest.food_restriction != ""}>
          Food Restrictions: <span><%= @guest.food_restriction %></span>
        </div>
        <div :if={@guest.housing_preference != ""}>
          Interested in camping on-site? <span><%= @guest.housing_preference %></span>
        </div>
        <div :if={@guest.notes != ""}>
          Notes: <span><%= @guest.notes %></span>
        </div>
        <.link patch={~p"/rsvp/#{@guest.uuid}/edit"}>✏️ edit</.link>
      </section>
      <p>Feel free to contact us directly if you have any questions or want to make changes!</p>
      <address>
        Nicolas Knoebber:
        knoebber@gmail.com
        /
        641-160-1703
      </address>
      <address>
        Anna Thompson:
        acthompson211@gmail.com
        /
        541-554-2795
      </address>
    </div>
    """
  end
end
