//
//  DetailsViewModel.swift
//  STL BFW
//
//  Created by Roger Jones Jr on 10/11/23.
//

import Foundation
import SwiftUI

final class  DetailsViewViewModel: ObservableObject {
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
        
        var isEvent: Bool {
            switch self {
            case .event(_):
                return true
            default:
                return false
            }
        }
        
    }

    @Published private (set) var headerImage: String?
    @Published private (set) var headerText: String?
    @Published private (set) var pretitleText: String?
    @Published private (set) var titleText: String
    @Published private (set) var descriptionText: String?
    @Published private (set) var imageUrl: String?
    @Published private (set) var location: Location?
    @Published private (set) var links: Links?
    @Published private (set) var type: Category
    @Published var fullImage: String = ""

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

            if let ig = designer.instagram,
               designer.website == nil {
                links = Links(instagram: Link(title: "Instagram",
                                              image: "camera.circle",
                                              url: ig))
            } else if let web = designer.website,
                      let ig = designer.instagram {
                links = Links(instagram: Link(title: "Instagram",
                                              image: "camera.circle",
                                              url: ig),
                              website: Link(title: "Website",
                                            image: "globe",
                                            url: web))
                
            }

        case .event(let event):
            headerImage = event.image
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
        }
        type = category   
    }
    
    private func setup(category: DetailsViewViewModel.Category) {
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
    
    func showPersonalLink() -> Bool {
        switch type {
        case .designer(let designer):
            return designer.personalIg != nil
        default:
            break
        }
        return false
    }
    
    func imageSelected(image: String) {
        fullImage = image
    }
    
    func loadNext(category: DetailsViewViewModel.Category) {
        switch  category {
        case .designer(let current):
            let designers = Designer.designers
            let optionalIndex = designers.firstIndex(where: { temp in
                current.name == temp.name && current.brand == temp.brand
            })
            if let index = optionalIndex,
               index + 1 < designers.endIndex {
                setup(category: .designer(designers[index + 1]))
            } else {
                setup(category: .designer(designers[0]))
            }
        case .event(let current):
            let events = Event.events
            let optionalIndex = events.firstIndex(where: { temp in
                current.date == temp.date && current.title == temp.title
            })
            
            if let index = optionalIndex,
               index + 1 < events.endIndex {
                setup(category: .event(events[index + 1]))
            } else {
                setup(category: .event(events[0]))
            }
        default:
            return
        }
    }
}
