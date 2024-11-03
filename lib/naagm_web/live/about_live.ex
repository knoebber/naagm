defmodule NaagmWeb.AboutLive do
  use NaagmWeb, :live_view

  @impl Phoenix.LiveView
  def render(assigns) do
    ~H"""
    <div class="content about">
      <nav class="sub-nav">
        <.link
          :for={
            {label, anchor} <- [
              {"Location", "location"},
              {"How to get there", "directions"},
              {"Where to stay", "lodging"}
            ]
          }
          href={"##{anchor}"}
        >
          <%= label %>
        </.link>
      </nav>
      <section id="location">
        <h2>Date / Time / Location</h2>
        <p>
          Our venue is <a href="https://www.google.com/maps/place/Heartwood+Mendocino/@39.3272897,-123.7124695,12.23z/data=!4m9!3m8!1s0x8081b3e97bce8111:0x2c5657768bef1eb1!5m2!4m1!1i2!8m2!3d39.3201641!4d-123.7308204!16s%2Fg%2F11ry5n0t06?entry=ttu&g_ep=EgoyMDI0MTAyOS4wIKXMDSoASAFQAw%3D%3D">
            Heartwood Mendocino
          </a>.
          The ceremony will start at 4:30pm on June 21st, 2025.
        </p>
      </section>

      <section id="directions">
        <h2>How to get there</h2>
        <p>
          Hwy 1 along the Mendocino Coast is a popular road trip destination.
          If you are traveling, we hope you will make the most of it.
          From the north, we recommend hugging the coast for a spectacularly scenic drive.
          From the south, you will likely pass Anderson Valley on Hwy 128, which is also a significant destination for wineries and wine tasting.
        </p>
        <p>
          The closest airport is in Santa Rosa (2hr 30 from venue).
          Common alternative options are San Fransisco, Oakland, or Sacramento (~4 hr drives).
        </p>
        <p>
          Most guests will likely drive their own car to the venue.
          But if you can, we enthusiastically encourage carpooling with other guests!
          If you want to avoid driving on the windy road at night, there is plenty of room to camp on site.
          Ride share apps are not available.
          You can try the local taxi service, but cell service at our venue is limited, so it may be prudent to pre-arrange your return trip.
        </p>
        <p>
          Want to carpool? Make a post to connect with other guests on our carpool page!
        </p>
      </section>

      <section id="lodging">
        <h2>Where to Stay</h2>
        <p>
          Immerse yourself in the wedding: Complimentary tent camping is available at our venue - and it’s beautiful.
          Guests will share a communal bath house, lawn, and outdoor cooking area.
          This will be a fun environment for unstructured socialization throughout the weekend.
        </p>

        <p>
          Keep in mind that you will be in the thick of the action and there may be noise and disruptions - especially on Saturday night!
          And beware, you may be roped into a task or two if you are around during the day.
          Camping will be available Thurs-Sun, or you can extend your stay by reserving on Hipcamp.
          Reservations via Hipcamp are not necessary for Thurs-Sun night, but we would like to know of your intention to camp for our own planning purposes
          (Example:
          <a href="https://www.hipcamp.com/en-US/land/california-heartwood-mendocino-gv1qh7dm/sites/1093760?adults=1&children=0&srid=2392e3ed-69ca-462b-a427-40200bf2c1a3">
            hipcamp.com/en-US/land/california-heartwood-mendocino-gv1qh7dm/sites/1093760
          </a>
          )
        </p>
        <p>
          Immerse yourself in our life: For lengthier stays or more isolation, tent camping is also available at Cosmo’s Camp or at our place in Rancho Navarro.
          These are 45-55 min drives, respectively. Get in touch and we’ll hook you up, but here are some links for reference.
          <a href="https://www.hipcamp.com/en-US/land/california-south-facing-ridge-with-views-gwz6h29j?adults=1&children=0&srid=baf1b378-e01d-429b-ae78-9261f26f70aa">
            South Facing Ridge with Views
          </a>
          and
          <a href="https://www.hipcamp.com/en-US/land/california-rolling-fog-lookout-5x5hqjn8?adults=1&children=0&srid=c074a60e-2c4c-432f-91e7-899484247f6a">
            Rolling Fog Lookout
          </a>
        </p>
        <p>
          Looking for a tent? Check out REI for reasonable rentals.
        </p>
      </section>
    </div>
    """
  end
end
