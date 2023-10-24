//
//  Partner.swift
//  STL BFW
//
//  Created by Roger ADT on 10/4/23.
//

import Foundation

struct Partner: Identifiable, Cardable {
    let id = UUID()
    let name: String
    let eventName: String
    let location: Location?
    let imageName: String
    let instagram: String?
    let website: String?
    let description: String?
    var type: InfoCardModel.Category { InfoCardModel.Category.partner(self) }
    

    var infoCardModel: InfoCardModel {
        InfoCardModel(id: self.id,
                      headerText: self.name,
                      headerImageName: imageName,
                      pretitleText: self.location?.name,
                      titleText: eventName,
                      type: .partner(self))
    }

    static var Partners: [Partner] {
        [partner1, partner2, partner3, partner4, partner5].sorted { lhs, rhs in
            lhs.name < rhs.name
        }
    }


    private static var partner1: Partner {
        Partner(name: "Levels Restaurant & Lounge",
                eventName: "Tastemakers Dinner",
                location: Location.location1,
                imageName: "levels",
                instagram: "https://www.instagram.com/levels_restaurantstl/",
                website: "https://www.levelsstl.com",
                description: "The only Nigerian restaurant in St. Louis city serving authentic cuisine with a modern touch.")
    }

    private static var partner2: Partner {
        Partner(name: "Scene Event Space",
                eventName: "Culture Conversation",
                location: Location.location2,
                imageName: "scene",
        instagram: "https://www.instagram.com/sceneeventspacestl/",
        website: "https://www.sceneeventspace.com",
        description: "\"PREMIER EVENT SPACE FOR CREATIVITY & INNOVATION…\" \nScene Event Space is a premier multi-functional private event space for diverse social entertainment and corporate opportunities. located in Grand Center Arts & Entertainment District")
    }

    private static var partner3: Partner {
        Partner(name: "Whisky On Washington",
                eventName: "Wine Down Friday",
                location: Location.location3,
                imageName: "whisky",
        instagram: "https://www.instagram.com/whiskyonwashington",
        website: "https://www.whiskyonwashington.com",
        description: "Whisky on Washington is an intimate, elevated neighborhood whisky joint with a jukebox. We serve a selection of premium whisky, bourbon, and scotch in an unpretentious environment. The perfect third place for laid-back people with good taste.")
    }

    private static var partner4: Partner {
        Partner(name: "Lavish At The Randall",
                eventName: "Hip-Hop Party",
                location: Location.location4,
                imageName: "lavish",
        instagram: "https://www.instagram.com/LavishaffairsattheRandall/",
        website: "https://lavishaffairs.net",
        description: "We Bring Excitement. Your Day Is About Your Enjoyment.\nWe Bring Fun. We Are Committed To Making Your Night Fun.\nWe Make It Lavish. This Is Where Every Affair Is A Lavish Affair.")
    }

    private static var partner5: Partner {
        Partner(name: "Third Degree Glass Factory",
                eventName: "Runway Show",
                location: Location.location5,
                imageName: "third",
                instagram: "https://www.instagram.com/stlglass/",
                website: "https://thirddegreeglassfactory.com",
        description: "Third Degree Glass Factory (TDGF) is the only publicly accessible glass art community in the City of St. Louis. TDGF features three state-of-the-art studios in glassblowing, flameworking and fused glass; each are available for classes and experiences, as well as studio rentals for qualified artists. Guests will also enjoy a gallery filled with hundreds of handmade pieces by the artists in the studios, as well as a unique 6,000+ sq. ft. event space for private events up to 250 guests.")
    }
    
    private static var partner6: Partner {
        Partner(name: "Levels Restaurant & Lounge",
                eventName: "Tastemakers Dinner",
                location: Location.location1,
                imageName: "levels",
                instagram: "https://www.instagram.com/levels_restaurantstl/",
                website: "https://www.levelsstl.com",
                description: "The only Nigerian restaurant in St. Louis city serving authentic cuisine with a modern touch.")
    }
}
