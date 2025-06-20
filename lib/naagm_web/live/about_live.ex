defmodule NaagmWeb.AboutLive do
  use NaagmWeb, :live_view

  defp activities do
    [
      "Grab an empanada and a coffee from one of the cafes while driving through Boonville. Stop for woodfired pizza at Offspring or a burger at Jumbo's Win Win if you’re looking for a meal.",
      "Wine tasting in Anderson Valley - especially at Pennyroyal, where you can go wine and cheese tasting. Cider and beer are also produced in the valley.",
      "Visit an old growth redwood grove at Montgomery Woods or Hendy Woods (among the tallest trees in the world!)",
      "Swimming holes on the Navarro River along 128 or swimming at the Rancho Navarro pool (insider access only (; )!",
      "Enjoy panoramic ocean views while eating the duck at the Ledford House (unless you really want to order something else)",
      "Grab an ice cream at Frankies or a coffee at the Waiting Room, and then walk the Mendocino Headlands",
      "Canoe in and out with the tides and the seals on Big River. Outrigger canoe rentals are at Catch-a-Canoe. Other boats can put in on the river side of Big River Beach. Sea cave kayaking is also an option from Van Damme beach, but we haven’t done it before.",
      "Get lost wandering through the gardens, Victorian style buildings, alleyways, and shops of Mendocino village. Maybe you’ll find a chocolate shop or some new earrings.",
      "Eat out in Mendocino Village (Goodlife Cafe, MacCallum House, Flo, Luna Trattoria, Cafe Beaujoulais, etc). Reservations are probably necessary.",
      "Visit the Point Cabrillo Lighthouse: historic lighthouse north of town with a gorgeous view, tidepools, lighthouse tours, and history and science exhibits",
      "Stake a spot at the beach to watch the waves or throw a frisbee (Big River, Russian Gulch, Jughandle, etc)",
      "Pick a hike in one of the zillions of State Parks",
      "Watch the boats come in and out from Noyo Harbor over fish and chips at Sea Pal, a poke bowl from Princess Seafood, or a cocktail at the Noyo Harbor Inn",
      "Skunk Train: The skunk train uses historic tracks to offer rail bike tours and scenic train rides through the redwoods. They also have a \“secret\” forest bar.",
      "Go on a run with Nick. Fort Bragg coastal trail, Big River haul road, or whatever’s nearby",
      "Babysit Monty 🐶 the dog for the day :) It will be so fun.",
      "The prior weekend is the Comptche Fathers Day picnic and the sea urchin festival.",
      "The following weekend, the Flynn Creek Circus will be in town!"
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
              {"Schedule", "schedule"},
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
      <section class="about-text wavy-box" id="schedule">
        <h2>Schedule</h2>
        <p class="bold">
          Our wedding will take place at a family venue amongst the redwoods a few miles inland from the Mendocino Coast.
        </p>
        <p>
        <span class="bold">
        Thursday, June 19th (Juneteenth)</span><br/>
        3pm-8pm Open house at our home in Rancho Navarro (<a href="#directions-to-our-house">directions</a>)
        <br/>Casual light BBQ and snacks
        <br/>(This is on the way to Mendocino if you are coming from the Bay Area)
        <br/>18801 Bald Hills Rd, Navarro, CA 95463
        </p>
        <p>
        <span class="bold">Friday, June 20th</span><br/>
        6pm Casual welcome dinner
        <br/>Heartwood Mendocino, 40500 Little Lake Rd, Mendocino, CA 95460
        </p>
        <p>
        <span class="bold">Saturday, June 21st (The big day!)</span>
        <br/> 9am run with Nick at Big River.
        <br/> 4pm guest arrival.
        <br/> Ceremony, dinner, and reception to follow.
        <br/>Attire: semi-formal
        <br/>The venue is outdoors, so please be prepared to spend the evening in grass or gravel and mild outdoor temperature fluctuations.
        <br/>Heartwood Mendocino, 40500 Little Lake Rd, Mendocino, CA 95460
        </p>
        <p>
        <span class="bold">Sunday, June 22nd</span><br/>
        1pm-4pm Open house at our home in Rancho Navarro<br/>
        Swing by on your way out if you haven't yet had the chance to see our place
        <br/>18801 Bald Hills Rd, Navarro, CA 95463
        </p>
        <p>
          We really appreciate our family and friends gathering from far and wide and we are so excited to see you all in one place!
          Mendocino is truly a special place to visit, so if you have the time,
          check out our list of <a href="#activities">recommended activities</a> (restaurants, wine, epic coastline, redwoods, state parks, etc.)
        </p>
        <p class="bold">
          For more information, read on below, or contact us with any questions: <br />
          Anna Thompson --- acthompson211@gmail.com / 541-554-2795
          <br />Nicolas Knoebber --- knoebber@gmail.com / 641-160-1703
        </p>
      </section>

      <section class="about-text wavy-box" id="directions">
        <h2>How to get there</h2>
        <p>
          The closest airport is in Santa Rosa (2hr 15 from venue).
          Common alternative options are San Francisco, Oakland, or Sacramento (3hr 30 to 4 hr drives).
          You will need to either drive or carpool from the airport. There is no public transportation to the venue.
        </p>
        <p>
         Make a post to connect with other guests on our carpool page!<br />
          <.link
            class="button"
            target="_blank"
            href="https://docs.google.com/spreadsheets/d/1HrQxh5-3mfgJT7Wbe1e4NemLivAcLqmXeN-wQ3QOqa4/edit?gid=0#gid=0"
          >
            🚗 Carpool Sheet 🚙
          </.link>
        </p>
        <p>
          From the airport, put "Heartwood Mendocino" into your phone. It should direct you to 40500 Little Lake Rd in Mendocino.
          Some sections won't have phone service. If you want, you can refer to the full directions down below.
        </p>

        <p>
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
        <p>
          <strong>From the south (e.g. San Franscisco)</strong>
          <ol>
            <li>Drive north on highway 101</li>
            <li>In Cloverdale, take the highway 128 exit toward Mendocino (You will drive through Anderson Valley and our house on Hwy 128. Check out our list of local recommendations or stop by to say hi if you have time for a pitsop)</li>
            <li>At the coast, continue north onto highway 1 until you reach Mendocino</li>
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
            <li>In Leggett, take the highway 1 exit toward Fort Bragg</li>
            <li>Continue south through Fort Fragg, towards Mendocino</li>
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
      </section>

      <section class="about-text wavy-box" id="lodging">
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
          And beware, you may be roped into a task or two if you are around during the day.<br />
          Reservations via Hipcamp aren't necessary for Friday night or Saturday night, but we would like to know of your intention to camp for our own planning purposes.
          Let us know directly or with your RSVP.
          Extend your stay at Heartwood Mendocino beyond Fri-Sun by reserving on Hipcamp.
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
      <section class="about-text wavy-box" id="activities">
        <h2>What to do</h2>
        <p>These are recommendations from Anna and Nick, listed roughly in order from south (Anderson Valley) to north (Fort Bragg)</p>
        <ul>
          <li :for={activity <- activities()}>
            {activity}
          </li>
        </ul>
      </section>
      <section class="about-text wavy-box" id="faq">
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
        <h3>How do I get to the wedding venue?</h3>
          <p><a href="#directions">How to Get There</a></p>
        </div>
        <div id="directions-to-our-house">
          <h3>How do I get to your house?</h3>
          <p class="bold">This is not the wedding venue, but it is where we will be hosting the open house on Thursday and Sunday.</p>
          <p>
            Google maps is usually pretty reliable for directing people here. We will put out signs once you get to the entrance on Rancho Navarro.
          </p>
          <br/>
          <p>
            The address is: 18801 Bald Hills Rd, Navarro, CA 95463
          </p>
          <br/>
          <ol>
            <li>From the south, take  highway 101 to highway 128 (about 30 miles; Turn left/West). Fill up on gas in Cloverdale if you need it.</li>
            <li>From the north, take highway 1 to highway 128. Fill up on gas in Fort Bragg if you need it.</li>
            <li>Continue on highway 128 until Flynn Creek Rd. Turn onto Flynn Creek Rd and drive 2.2 miles.</li>
            <li>Turn right on Appian Way (entrance to Rancho Navarro); go another 2.2 miles.</li>
            <li>Stay left onto Tramway; continue ~1 mi up a steep hill.</li>
            <li>Turn Left on Bald Hills Rd (t-intersection...so turn left).</li>
            <li>Go 1/2 mile...Nick and Anna's on left. There are two driveways, use either depending on parking.</li>
          </ol>
        </div>
      </section>
    </div>
    """
  end
end
