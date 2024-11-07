defmodule NaagmWeb.AboutLive do
  use NaagmWeb, :live_view

  defp activities do
    [
      "Grab an ice cream at Frankies or a coffee at the Waiting Room, and then walk the Mendocino Headlands",
      "Enjoy panoramic ocean views while eating the duck at the Ledford House (unless you really want to order something else)",
      "Visit an old growth redwood grove at Montgomery Woods or Hendy Woods (among the tallest trees in the world!)",
      "Canoe in and out with the tides and the seals on Big River. Outrigger canoe rentals are at Catch-a-Canoe. Other boats can put in on the river side of Big River Beach. Sea cave kayaking is also an option from Van Damme beach, but we haven’t done it before.",
      "Watch the boats come in and out from Noyo Harbor over fish and chips at Sea Pal, a poke bowl from Princess Seafood, or a cocktail at the Noyo Harbor Inn",
      "Wine tasting in Anderson Valley - especially at Pennyroyal, where you can go wine and cheese tasting. Cider and beer are also produced in the valley.",
      "Grab and empanada and a coffee from one of the cafes while driving through Boonville. Stop for woodfired pizza at Offspring if you’re looking for a meal.",
      "Get lost wandering through the gardens, Victorian style buildings, alleyways, and shops of Mendocino village. Maybe you’ll find a chocolate shop or earrings.",
      "Visit the Point Cabrillo Lighthouse: historic lighthouse north of town with a gorgeous view, tidepools, lighthouse tours, and history and science exhibits",
      "Pick a hike in one of the zillions of State Parks",
      "Stake a spot at the beach to watch the waves or throw a frisbee (Big River, Russian Gulch, Jughandle, etc)",
      "Eat out in Mendocino Village (Goodlife Cafe, MacCallum House, Flo, Luna Trattoria, Cafe Beaujoulais, etc). Reservations are probably necessary.",
      "Swimming holes on the Navarro River along 128 or swimming at the Rancho Navarro pool (insider access only (; )!",
      "Go on a run with Nick. Fort Bragg coastal trail, Big River haul road, or whatever’s nearby",
      "Babysit Monty the dog for the day :) It will be so fun.",
      "Skunk Train: The skunk train uses historic tracks to offer rail bike tours and scenic train rides through the redwoods. They also have a \“secret\” forest bar."
    ]
  end

  defp faq do
    [
      {"What should I wear?", "Whatever you want!"},
      {"Can I bring my kiddos?",
       "Yes please! We want to see your whole family and we hope this will be a fun event for all! Just be sure to RSVP for your entire group, including kids."},
      {"Do I get a plus one?",
       "We are happy for our invited guests to bring a plus one, as long as you RSVP for them as well as yourself."},
      {"Can I bring my dog?",
       "No dogs at the wedding. But if you are staying on site for the whole weekend, you may bring your dog within the rules of Heartwood (well behaved, leashed, etc). If you do, please make arrangements to keep your dog off site during the day and overnight on Saturday."},
      {"Food intolerances and allergies",
       "Please provide clear instructions with your RSVP, which we will share with our caterer. If your situation is serious or complex, we will likely reach out to you or put you in direct contact with our caterer to make sure nothing gets lost in translation. Reach out with questions! How should I get there? Link to Trip Planning - How to Get There page."},
      {"I need to edit my RSVP",
       "Please contact us directly and we can help you to update your RSVP."}
    ]
  end

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
              {"Where to stay", "lodging"},
              {"What to do", "activities"},
              {"FAQ", "faq"}
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
          Our venue is Heartwood Mendocino:
          <iframe
            src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d84377.38904807776!2d-123.7124695069704!3d39.327289712225976!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x8081b3e97bce8111%3A0x2c5657768bef1eb1!2sHeartwood%20Mendocino!5e0!3m2!1sen!2sus!4v1730652964898!5m2!1sen!2sus"
            width="600"
            height="450"
            style="border:0;"
            allowfullscreen=""
            loading="lazy"
            referrerpolicy="no-referrer-when-downgrade"
          >
          </iframe>
        </p>
        <p>
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
        <h3>Tent Camping</h3>
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
        <h3>Hotels, vacation rentals, and more</h3>
        <p>
          The Mendocino Coast is a popular spot, so there are some fabulous options if you BOOK AHEAD!
          Beyond hotels, we recommend expanding your search to vacation homes and bed & breakfasts.
          Expand your search to anywhere between Fort Bragg and Little River.
        </p>
      </section>
      <section id="activities">
        <h2>What to do</h2>
        <ul>
          <li :for={activity <- activities()}>
            <%= activity %>
          </li>
        </ul>
      </section>
      <section id="faq">
        <h2>FAQ</h2>
        <div :for={{question, answer} <- faq()}>
          <h3><%= question %></h3>
          <p><%= answer %></p>
        </div>
      </section>
    </div>
    """
  end
end
