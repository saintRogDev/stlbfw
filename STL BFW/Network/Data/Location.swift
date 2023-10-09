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

    static var location1: Location {
        Location(name: "Private Location",
                 address: "Private Location")
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
        Location(name: "Lavish At The Randall",
                 address: "999 North 13th Street, St. Louis, MO, 63106")
    }

    static var location5: Location {
        Location(name: "THIRD DEGREE GLASS FACTORY",
                 address: "5200 Delmar Blvd, St. Louis, MO, 63108")
    }
}
