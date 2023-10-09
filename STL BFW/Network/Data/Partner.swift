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
        [partner1, partner2, partner3, partner4, partner5]
    }


    private static var partner1: Partner {
        Partner(name: "Levels Restaurant & Lounge",
                eventName: "Tastemakers Dinner",
                location: Location.location1,
                imageName: "levels")
    }

    private static var partner2: Partner {
        Partner(name: "Scene Event Space",
                eventName: "Culture Conversation",
                location: Location.location2,
                imageName: "scene")
    }

    private static var partner3: Partner {
        Partner(name: "Whisky On Washington",
                eventName: "Wine Down Friday",
                location: Location.location3,
                imageName: "whisky")
    }

    private static var partner4: Partner {
        Partner(name: "Lavish At The Randall",
                eventName: "Hip-Hop Party",
                location: Location.location4,
                imageName: "lavish")
    }

    private static var partner5: Partner {
        Partner(name: "Third Degree Glass Factory",
                eventName: "Runway Show",
                location: Location.location5,
                imageName: "third")
    }
}
