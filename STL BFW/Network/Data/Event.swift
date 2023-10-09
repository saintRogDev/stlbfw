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
            Link(url: "https://tmooremedia.ticketleap.com/stlbfw23/dates/Nov-02-2023_at_0700PM",
                 title: "Get Tickets")
        }
        static var link2: Link {
            Link(url: "https://tmooremedia.ticketleap.com/stlbfw23/dates/Nov-03-2023_at_0700PM",
                 title: "Get Tickets")
        }
        static var link3: Link {
            Link(url: "https://tmooremedia.ticketleap.com/stlbfw23/dates/Nov-04-2023_at_0700PM",
                 title: "Get Tickets")
        }
        static var link4: Link {
            Link(url: "https://tmooremedia.ticketleap.com/stlbfw23/dates/Nov-05-2023_at_0500PM",
                 title: "Get Tickets")
        }
    }

    let id = UUID()
    let title: String
    let date: String
    let description: String
    let location: Location
    let link: Link?
    var type: InfoCardModel.Category { InfoCardModel.Category.event(self) }

    var infoCardModel: InfoCardModel {
        InfoCardModel(id: self.id,
                      headerText: self.title.uppercased(),
                      headerImageName: nil,
                      pretitleText: self.location.name,
                      titleText: self.date,
                      type: .event(self))
    }

    static var events: [Event] {
        [event1, event2, event3, event4, event5]
    }

    private static var event1: Event {
        Event(title: "Private Dinner",
              date: "NOVEMBER 1st 6:00 PM",
              description: "Culinary excellence and cultural exchange at our Tastemakers Dinner, proudly presented in partnership with D'USSÉ. Join us for a gourmet feast, paired with curated conversations about the intersection of food, culture and fashion. This exclusive event is a blend of flavors, style, and inspiration, with D'USSÉ Cognac adding a touch of sophistication to the evening's libations. Join us for an unforgettable culinary and cultural journey.",
              location: Location.location1,
              link: nil)
    }

    private static var event2: Event {
        Event(title: "Session 314",
              date: "NOVEMBER 2nd 7:00 PM",
              description: "Engage in thought-provoking discussions at Culture Conversations. Explore the rich history of hip hop culture, its influence on fashion, and its social impact. Join industry experts, artists, and influencers in intimate dialogues that dive deep into the essence of style and language.",
              location: Location.location2,
              link: Link.link1)
    }

    private static var event3: Event {
        Event(title: "Culture Talk  & Exclusive Museum",
              date: "NOVEMBER 3rd 7:00 PM",
              description: "Experience the first city premiere of a captivating commercial that shines light on our impact on fashion and fitness over the past 50 years. After the screening, gather around the fireside for an insightful chat with the film's creators and talent gaining exclusive insights into the making of this groundbreaking project.",
              location: Location.location3,
              link: Link.link2)
    }

    private static var event5: Event {
        Event(title: "Fashion Day Party",
              date: "NOVEMBER 5th 5:00 PM",
              description: "Let loose and celebrate at our hip hop and fashion infused party proudly presented in partnership with HUSH™ Event Series. Hang loose and Jam to the hottest beats, showcase your unique style, and revel in the vibrant atmosphere. It's a night of music, fashion, and unforgettable moments.",
              location: Location.location4, 
              link: Link.link3)
    }

    private static var event4: Event {
        Event(title: "9th Annual Fashion Show",
              date: "NOVEMBER 4th 7:00 PM",
              description: "Come out and witness the culmination of 50 years of hip hop influence on the runway at our Grand Finale. Top designers and models will showcase cutting-edge collections inspired by the rhythm and spirit of hip hop. It's a spectacular showcase of style, culture, and creativity that you won't want to miss.",
              location: Location.location5, 
              link: Link.link4)
    }
}
