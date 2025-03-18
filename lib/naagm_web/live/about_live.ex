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
      "Grab an empanada and a coffee from one of the cafes while driving through Boonville. Stop for woodfired pizza at Offspring or a burger at Jumbo's Win Win if you’re looking for a meal.",
      "Get lost wandering through the gardens, Victorian style buildings, alleyways, and shops of Mendocino village. Maybe you’ll find a chocolate shop or earrings.",
      "Visit the Point Cabrillo Lighthouse: historic lighthouse north of town with a gorgeous view, tidepools, lighthouse tours, and history and science exhibits",
      "Pick a hike in one of the zillions of State Parks",
      "Stake a spot at the beach to watch the waves or throw a frisbee (Big River, Russian Gulch, Jughandle, etc)",
      "Eat out in Mendocino Village (Goodlife Cafe, MacCallum House, Flo, Luna Trattoria, Cafe Beaujoulais, etc). Reservations are probably necessary.",
      "Swimming holes on the Navarro River along 128 or swimming at the Rancho Navarro pool (insider access only (; )!",
      "Go on a run with Nick. Fort Bragg coastal trail, Big River haul road, or whatever’s nearby",
      "Babysit Monty 🐶 the dog for the day :) It will be so fun.",
      "Skunk Train: The skunk train uses historic tracks to offer rail bike tours and scenic train rides through the redwoods. They also have a \“secret\” forest bar."
    ]
  end

  defp faq do
    [
      {"Can I bring my kiddos?",
       "Yes please! We want to see your whole family and we hope this will be a fun event for all! Just be sure to RSVP for your entire group, including kids."},
      {"Do I get a plus one?",
       "We are happy for our invited guests to bring a plus one, as long as you RSVP for them as well as yourself."},
      {"Can I bring my dog?",
       "No dogs at the wedding. But if you are staying on site for the whole weekend, you may bring your dog within the rules of Heartwood (well behaved, leashed, etc). If you do, please make arrangements to keep your dog off site during the day and overnight on Saturday."},
      {"Food intolerances and allergies",
       "Please provide clear instructions with your RSVP, which we will share with our caterer. If your situation is serious or complex, we will likely reach out to you or put you in direct contact with our caterer to make sure nothing gets lost in translation. Reach out with questions! "},
      {"I need to edit my RSVP",
       "Please contact us directly and we can help you to update your RSVP. Please RSVP by May 21st."}
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
              {"Overview", "overview"},
              {"How to get there", "directions"},
              {"Where to stay", "lodging"},
              {"What to do", "activities"},
              {"FAQ", "faq"}
            ]
          }
          href={"##{anchor}"}
        >
          {label}
        </.link>
      </nav>
      <section id="overview">
        <h2>Overview 👁️👁️</h2>
        <p class="bold">
          Our wedding will take place at a family venue amongst the redwoods a few miles inland from the Mendocino Coast.
        </p>
        <p>
        <span class="bold">Schedule of events<br/>
        Thursday/Sunday</span><br/>
        Open house at our home in Rancho Navarro<br/>Times to will be posted here at a later date.
        <br/>18801 Bald Hills Rd, Navarro, CA 95463
        </p>
        <p>
        <span class="bold">Friday, June 20th</span><br/>
        Casual welcome dinner<br/>6pm<br/>Heartwood Mendocino<br/>40500 Little Lake Rd, Mendocino, CA 95460
        </p>
        <p>
        <span class="bold">Saturday, June 21st</span><br/>
        The big day!<br/>
        4pm guest arrival<br/>Ceremony, dinner, and reception to follow.<br/>
        Attire: semi-formal
        <br/>Heartwood Mendocino<br/>40500 Little Lake Rd, Mendocino, CA 95460
        </p>
        <p class="bold">
          For more information, read on below, or contact us with any questions: <br />
          Anna Thompson --- acthompson211@gmail.com / 541-554-2795
          <br />Nicolas Knoebber --- knoebber@gmail.com / 641-160-1703
        </p>

        <p>
          The venue is outdoors, so please be prepared to spend the evening in grass or gravel and mild outdoor temperature fluctuations.
        </p>

        <p>
          We really appreciate our family and friends gathering from far and wide and we are so excited to see you all in one place!
          To that end, we hope to spend additional time with folks visiting from out of town.
          So, share your travel plans with us and check back as the time draws nearer, since we hope to coordinate some additional informal gatherings in the days before the wedding.
          <.link href="#lodging">Camping at the venue</.link>
          is also available for more unstructured social time.
          Mendocino is truly a special place to visit, so if you have the time,
          there is plenty to do and see (restaurants, wine, epic coastline, redwoods, state parks, etc.).
          We outlined some of our favorite destinations later on this page.
        </p>
        <p>
          <strong>Our venue is Heartwood Mendocino</strong>
          <iframe
            src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d84377.38904807776!2d-123.7124695069704!3d39.327289712225976!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x8081b3e97bce8111%3A0x2c5657768bef1eb1!2sHeartwood%20Mendocino!5e0!3m2!1sen!2sus!4v1730652964898!5m2!1sen!2sus"
            style="width: 100%"
            height="450"
            style="border:0;"
            allowfullscreen=""
            loading="lazy"
            referrerpolicy="no-referrer-when-downgrade"
          >
          </iframe>
        </p>
      </section>

      <section id="directions">
        <h2>How to get there</h2>
        <p>
          The closest airport is in Santa Rosa (2hr 15 from venue).
          Common alternative options are San Francisco, Oakland, or Sacramento (3hr 30 to 4 hr drives).
          You will need to either drive or carpool from the airport, there isn't public transportation to the venue.
        </p>
        <p>
          From the airport, put "Heartwood Mendocino" into your phone. It should direct you to an address in Mendocino on Little Lake road.
          Some sections won't have phone service. If you want, you can write the full directions down below.
        </p>
        <p>
          <strong>From the south (e.g. San Franscisco)</strong>
          <ol>
            <li>Drive north on highway 101</li>
            <li>Take the highway 128 exit in Cloverdale to Mendocino</li>
            <li>Continue onto highway 1 and drive north until Mendocino</li>
            <li>Take a right at the stoplight in Mendocino onto Little Lake Road</li>
            <li>
              Drive on Little Lake until you see a sign for Heartwood Mendocino and a sign for our wedding!
            </li>
            <li>Take a left into the driveway and follow directions to park</li>
          </ol>
          This route will take you right by our house in Navarro. Stop by if you'd like!
        </p>
        <p>
          <strong>From the north (e.g. Eugene)</strong>
          <ol>
            <li>Drive south on I-5</li>
            <li>In Grants Pass, turn onto highway 199</li>
            <li>In Crescent City, drive south on highway 101</li>
            <li>Take the highway 1 exit in Leggett to Fort Bragg</li>
            <li>Drive south towards Mendocino</li>
            <li>Take a left at the stoplight in Mendocino onto Little Lake Road</li>
            <li>
              Drive on Little Lake until you see a sign for Heartwood Mendocino and a sign for our wedding!
            </li>
            <li>Take a left into the driveway and follow directions to park</li>
          </ol>
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
          <.link
            class="button"
            target="_blank"
            href="https://docs.google.com/spreadsheets/d/1HrQxh5-3mfgJT7Wbe1e4NemLivAcLqmXeN-wQ3QOqa4/edit?gid=0#gid=0"
          >
            🚗 Carpool Sheet 🚙
          </.link>
        </p>
      </section>

      <section id="lodging">
        <h2>Where to Stay</h2>
        <h3>Tent Camping</h3>
        <p>
          Immerse yourself in the wedding:
          <a href="https://docs.google.com/forms/d/e/1FAIpQLSdEVzqLL8WLLTMKfojRO0H7r6da-qhsHm20Phql8HFZNVdz9Q/viewform">
            Tent camping
          </a>
          is available at Heartwood Mendocino (our venue), and it’s beautiful.
          Guests will share a communal bath house, lawn, and outdoor cooking area.
          This will be a fun environment for unstructured socialization throughout the weekend.
          Keep in mind that you will be in the thick of the action and there may be noise and disruptions - especially on Saturday night!
          And beware, you may be roped into a task or two if you are around during the day.
          Reservations via Hipcamp are not necessary for Thurs-Sun, but we would like to know of your intention to camp for our own planning purposes.
          Let us know directly or with your RSVP.
          Extend your stay at Heartwood Mendocino beyond Thurs-Sun by reserving on Hipcamp.
        </p>
        <p>
          Immerse yourself in our life: For lengthier stays or more isolation, tent camping is also available at
          <a href="https://www.hipcamp.com/en-US/land/california-south-facing-ridge-with-views-gwz6h29j?adults=1&children=0&srid=baf1b378-e01d-429b-ae78-9261f26f70aa">
            Cosmo’s Camp
          </a>
          (Nick’s dad’s place) or at
          <a href="https://www.hipcamp.com/en-US/land/california-rolling-fog-lookout-5x5hqjn8?adults=1&children=0&srid=c074a60e-2c4c-432f-91e7-899484247f6a">
            our place
          </a>
          in Rancho Navarro. These are 45-55 min drives, respectively.
          Get in touch and we’ll hook you up (no need to make reservations via Hipcamp), but follow the links for reference.
        </p>
        <p>Looking for a tent? Check out REI for reasonable rentals.</p>
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
            {activity}
          </li>
        </ul>
      </section>
      <section id="faq">
        <h2>FAQ</h2>
        <div>
          <h3>What I should I wear?</h3>
          <p>Semi-formal or whatever makes you comfortable. Feel free to have fun with it!</p>
          <p>Remember that this event is outside in grass and gravel. Avoid high heels or keep them chunky. Bring a layer for an evening outdoors.</p>
        </div>
        <div :for={{question, answer} <- faq()}>
          <h3>{question}</h3>
          <p>{answer}</p>
        </div>
        <div>
          <h3>How should I get there?</h3>
          <p><a href="#directions">Link to Trip Planning - How to Get There page.</a></p>
        </div>
      </section>
    </div>
    """
  end
end
