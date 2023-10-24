//
//  Event.swift
//  STL BFW
//
//  Created by Roger ADT on 10/4/23.
//

import Foundation


struct Event: Identifiable {
    struct Link {
        let url: String
        let title: String

        static var link1: Link {
            Link(url: "http://tmooremedia.ticketleap.com/stlbfw23/dates/Nov-02-2023_at_0700PM",
                 title: "Get Tickets")
        }
        static var link2: Link {
            Link(url: "http://tmooremedia.ticketleap.com/stlbfw23/dates/Nov-03-2023_at_0700PM",
                 title: "Get Tickets")
        }
        static var link3: Link {
            Link(url: "http://tmooremedia.ticketleap.com/stlbfw23/dates/Nov-04-2023_at_0700PM",
                 title: "Get Tickets")
        }
        static var link4: Link {
            Link(url: "http://tmooremedia.ticketleap.com/stlbfw23/dates/Nov-05-2023_at_0500PM",
                 title: "Get Tickets")
        }
    }

    let id = UUID()
    let shortTitle: String
    let title: String
    let date: String
    let description: String
    let location: Location
    let link: Link?
    var type: InfoCardModel.Category { InfoCardModel.Category.event(self) }

    var infoCardModel: InfoCardModel {
        InfoCardModel(id: self.id,
                      headerText: self.shortTitle.uppercased(),
                      headerImageName: nil,
                      pretitleText: self.location.name,
                      titleText: self.date,
                      type: .event(self))
    }

    static var events: [Event] {
        [event1, event2, event3, event4, event5]
    }

    private static var event1: Event {
        Event(shortTitle: "Private Dinner",
              title: "Private Dinner Powered By Dusse",
              date: "November 1, 7:00-9:00 PM",
              description: "Culinary excellence and cultural exchange at our Tastemakers Dinner, proudly presented in partnership with D'USSÉ. Join us for a gourmet feast, paired with curated conversations about the intersection of food, culture and fashion. This exclusive event is a blend of flavors, style, and inspiration, with D'USSÉ Cognac adding a touch of sophistication to the evening's libations. Join us for an unforgettable culinary and cultural journey. This event is invite only",
              location: Location.location,
              link: nil)
    }

    private static var event2: Event {
        Event(shortTitle: "Session 314",
              title: "Session 314: At The Intersection Of Hip-Hop",
              date: "November 2, 7:00-9:00 PM",
              description: "Get ready for convo at the cultural crossroads of hip-hop and discover the insights, stories, and experiences of St. Louis's powerhouse movers and shakers. This electrifying event promises engaging discussions, inspiring anecdotes, and a chance to connect with individuals who have left an indelible mark on our city.",
              location: Location.location2,
              link: Link.link1)
    }

    private static var event3: Event {
        Event(shortTitle: "Culture Talk",
              title: "Culture Talk & Exclusive Museum Ft. Vokal",
              date: "November 3, 7:00-9:00 PM",
              description: "Dive into the cultural legacy of Vokal with the Founder himself, Yomi Martin! Vokal is one of the most iconic clothing lines of Hip-Hop that gained fame through the talents of St. Louis native Nelly but retained loyalty, love and support by the 314! Vokal opened the door for brands that were birthed for years to come. Explore the rich history, style, and impact of this celebrated brand while enjoying an exclusive museum exhibit that pays homage to its influence on fashion and culture and much more.",
              location: Location.location2,
              link: Link.link2)
    }

    private static var event5: Event {
        Event(shortTitle: "Day Party",
              title: "Fashion Day Party x Niddy Gritty",
              date: "November 5, 5:00-10:00 PM",
              description: "This event will bring together multiple DJs, curated by the premier event curator of our city, Niddy Gritty. DJs will be spinning the hottest music from the daytime into the night. Enjoy great company and vibe in rich energy. It's the perfect way to wrap up an incredible week of fashion and culture at Saint Louis Black Fashion Week.",
              location: Location.location4,
              link: Link.link4)
    }

    private static var event4: Event {
        Event(shortTitle: "Fashion Show",
              title: "9th Annual Fashion Show",
              date: "November 4, 7:00-10:00 PM",
              description: "This annual event is the epitome of style and innovation, showcasing the incredible talent of 10 Amazing Saint Louis Designers. Prepare to be entertained by their collections as they hit the runway, setting the stage for an unforgettable evening of culture and entertainment.",
              location: Location.location5,
              link: Link.link3)
    }
}
