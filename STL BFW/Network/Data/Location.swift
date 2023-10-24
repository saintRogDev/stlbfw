//
//  Location.swift
//  STL BFW
//
//  Created by Roger ADT on 10/4/23.
//

import Foundation
struct Location {
    let name: String?
    let address: String
    
    static var location: Location {
        Location(name: "Invite Only", address: "")
    }

    static var location1: Location {
        Location(name: "Levels Restaurant",
                 address: "1405 Washington Ave, St. Louis, MO 63103")
    }

    static var location2: Location {
        Location(name: "Scene Event Space",
                 address: "3333 Washington Ave Suite 120, St. Louis, MO, 63103")
    }

    static var location3: Location {
        Location(name: "Whisky On Washington",
                 address: "1321 Washington Ave, St. Louis, MO, 63103")
    }

    static var location4: Location {
        Location(name: "HG Event Space",
                 address: "2617 Washington Ave B, St. Louis, MO, 63103")
    }

    static var location5: Location {
        Location(name: "Gateway Classic Cars",
                 address: "1237 Central Park Dr #1, O'Fallon, IL, 62269")
    }
}
