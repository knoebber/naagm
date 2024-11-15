defmodule NaagmWeb.AdminGuestLive do
  alias Naagm.Guests

  use NaagmWeb, :live_view

  defp assign_data(socket) do
    all_guests = Guests.list_guests()

    {total_responses, total_coming} =
      Enum.reduce(all_guests, {0, 0}, fn guest, {invited, coming} ->
        Enum.reduce(
          guest.parsed_party,
          {invited, coming},
          fn member, {invited, coming} ->
            {invited + 1, if(member.is_coming, do: coming + 1, else: coming)}
          end
        )
      end)

    socket
    |> assign(:guests, all_guests)
    |> assign(:total_responses, total_responses)
    |> assign(:total_coming, total_coming)
  end

  @impl Phoenix.LiveView
  def mount(_params, _session, socket) do
    {:ok, assign_data(socket)}
  end

  @impl Phoenix.LiveView
  def render(assigns) do
    ~H"""
    <div class="admin-guest-wrapper">
      <span>Count: <%= "#{@total_coming}/#{@total_responses}" %></span>
      <table>
        <thead>
          <tr>
            <th>Link</th>
            <th>Party</th>
            <th>Food Preference</th>
            <th>Food Restriction</th>
            <th>Housing Preference</th>
            <th>Notes</th>
            <th>Created At</th>
          </tr>
        </thead>
        <tbody>
          <tr :for={guest <- @guests} class="guest-row">
            <td><.link navigate={~p"/rsvp/#{guest.uuid}"}>🔗</.link></td>
            <td>
              <ul>
                <li :for={member <- guest.parsed_party}>
                  <%= if member.is_coming do %>
                    <%= member.full_name %>
                  <% else %>
                    <del><%= member.full_name %></del>
                  <% end %>
                </li>
              </ul>
            </td>
            <td><%= guest.food_preference %></td>
            <td><%= guest.food_restriction %></td>
            <td><%= guest.housing_preference %></td>
            <td><%= guest.notes %></td>
            <td><%= guest.inserted_at %></td>
          </tr>
        </tbody>
      </table>
    </div>
    """
  end
end
