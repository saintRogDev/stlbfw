//
//  DetailsView.swift
//  STL BFW
//
//  Created by Roger ADT on 9/23/23.
//

import SwiftUI
import MapKit

struct DetailsViewViewModel {
    struct Link {
        let title: String
        let image: String?
        let url: String

        func clicked() {
            if let url = URL(string: self.url) {
                UIApplication.shared.open(url)
            }
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
            case .designer(_):
                return .center
            default:
                return . leading
            }
        }
    }

    let headerImage: String?
    let headerText: String?
    let pretitleText: String?
    let titleText: String
    let descriptionText: String?
    let imageUrl: String?
    let location: String?
    let links: [Link]?
    let type: Category

    init (category: DetailsViewViewModel.Category) {
        switch category {
        case .designer(let designer):
            headerImage = nil
            headerText = designer.brand
            pretitleText = nil
            titleText = designer.name
            descriptionText = designer.description
            imageUrl = designer.instagram
            location = nil
            links = [Link(title: "Instagram", image: "camera.circle", url:  "www.instagram.com" ),
                     Link(title: "Website", image: "globe", url: "www.google.com")]

        case .event(let event):
            headerImage = nil
            headerText = event.title
            pretitleText = event.date
            titleText = event.title
            descriptionText = event.description
            imageUrl = nil
            location = event.location.address
            links = nil

        case .partner(let partner):
            headerImage = partner.imageName
            headerText = nil
            pretitleText = nil
            titleText = partner.eventName
            descriptionText = partner.location?.name
            imageUrl = nil
            location = partner.location?.address
            links = nil
        }
        type = category
    }
}


struct DetailsView: View {
    @Environment(\.colorScheme) var colorScheme
    let vm: DetailsViewViewModel

    init(category: DetailsViewViewModel.Category) {
        vm = DetailsViewViewModel(category: category)
    }

    var body: some View {
        VStack (spacing: 10) {
           header
            VStack(alignment: vm.imageUrl != nil ? .center : .leading, spacing: 6) {
                vm.pretitleText.map {
                    Text($0)
                        .preTitleText(size: 14,
                                      scheme: colorScheme)
                }
                Text(vm.titleText)
                    .titleText(size: 20,
                    scheme: colorScheme)
                ScrollView {
                    description
                    links
                    mapView
                }
            }
            .padding(.horizontal, 14)
            Spacer()
        }
        .background {
            colorScheme == .light ? Color.white : Color.black
        }
    }

    var header: some View {
        VStack {
            VStack(spacing: 0) {
                ZStack {
                    Color(.black)
                        .frame(maxWidth: .infinity,
                               maxHeight: 200)
                    vm.headerText.map {
                        Text($0)
                            .headingText(size: 35)
                            .padding(.horizontal, 20)
                    }
                    vm.headerImage.map {
                        Image($0)
                            .clipped()
                    }
                }
                
            }
            .frame(maxHeight: 150)
            vm.imageUrl.map { _ in
                Circle()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.gray)
                    .padding(.top, -50)
            }
        }
    }

    var description: some View {
        vm.descriptionText.map {
            Text($0)
                .detailsText(size: 15,
                             textAlignment: vm.type.descriptionAlignment,
                             scheme: colorScheme)
        }
    }

    var mapView: some View {
        vm.location.map {
            MapView(address: $0)
                .frame(width: 350, height: 200)
                .clipShape(RoundedRectangle(cornerRadius: 8.0))
                .padding(.top, 10)
        }
    }

    var  links: some View {
        vm.links.map { links in
            HStack {
                Spacer()
                Button {
                    links[0].clicked()
                } label: {
                    if let imageName = links[0].image {
                        Label("\(links[0].title)", systemImage: imageName )
                    } else {
                        Text("\(links[0].title)")
                    }
                }
                if links.count > 1 {
                    let link2 = links[1]
                    Spacer()
                    Button {
                        link2.clicked()
                    } label: {
                        if let imageName = link2.image {
                            Label("\(link2.title)", systemImage: imageName )
                        } else {
                            Text("\(link2.title)")
                        }
                    }
                    Spacer()
                }
            }
            .padding(.vertical, 5)
        }
    }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        Text("Hello World")
    }
}

