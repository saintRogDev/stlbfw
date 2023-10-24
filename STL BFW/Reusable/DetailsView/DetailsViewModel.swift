//
//  DetailsViewModel.swift
//  STL BFW
//
//  Created by Roger Jones Jr on 10/11/23.
//

import Foundation
import SwiftUI

struct DetailsViewViewModel {
    struct Link {
        let title: String
        let image: String?
        let url: String
    }
    
    struct Links {
        let instagram: Link?
        let website: Link?
        let tickets: Link?
        init(instagram: Link? = nil,
             website: Link? = nil,
             tickets: Link? = nil) {
            self.instagram = instagram
            self.website = website
            self.tickets = tickets
        }
    }

    enum Category: Identifiable {
        case designer(Designer)
        case event(Event)
        case partner(Partner)

        var id: UUID {
            switch self {
            case .designer(let designer):
                return designer.id
            case .event(let event):
                return event.id
            case .partner(let partner):
                return partner.id
            }
        }

        var descriptionAlignment: TextAlignment {
            switch self {
            default:
                return .leading
            }
        }
    }

    let headerImage: String?
    let headerText: String?
    let pretitleText: String?
    let titleText: String
    let descriptionText: String?
    let imageUrl: String?
    let location: Location?
    private (set) var links: Links?
    let type: Category

    init (category: DetailsViewViewModel.Category) {
        switch category {
        case .designer(let designer):
            headerImage = designer.headerImageName
            headerText = designer.brand
            pretitleText = nil
            titleText = designer.name
            descriptionText = designer.description
            imageUrl = designer.spreadImage
            location = nil

            if let ig = designer.instagram {
                links = Links(instagram: Link(title: "Instagram",
                                              image: "camera.circle",
                                              url: ig))
            }
            if let web = designer.website {
                let currentIg = links?.instagram
                links = Links(instagram: currentIg,
                              website: Link(title: "Website",
                                            image: "globe",
                                            url: web))
                
            }

        case .event(let event):
            headerImage = nil
            headerText = event.shortTitle
            pretitleText = event.date
            titleText = event.title
            descriptionText = event.description
            imageUrl = nil
            location = event.location
            links =  event.link.map {
                Links(tickets: Link(title: $0.title,
                                    image: "pass",
                                    url: $0.url))
            }

        case .partner(let partner):
            headerImage = partner.imageName
            headerText = nil
            pretitleText =  partner.eventName
            titleText = partner.location?.name ?? ""
            descriptionText = partner.description
            imageUrl = nil
            location = partner.location
            if let ig = partner.instagram {
                links = Links(instagram: Link(title: "Instagram",
                                              image: "camera.circle",
                                              url: ig))
            }
            if let web = partner.website {
                let currentIg = links?.instagram
                links = Links(instagram: currentIg,
                              website: Link(title: "Website",
                                            image: "globe",
                                            url: web))
                
            }
        }
        type = category
    }
}
