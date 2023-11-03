//
//  DetailsView.swift
//  STL BFW
//
//  Created by Roger ADT on 9/23/23.
//

import MapKit
import SafariServices
import SwiftUI

struct DetailsView: View {
    @Environment(\.colorScheme) var colorScheme
    @State var showTicketLink = false
    private let vm: DetailsViewViewModel

    init(category: DetailsViewViewModel.Category) {
        vm = DetailsViewViewModel(category: category)
    }

    var body: some View {
        VStack (spacing: 10) {
           header
            VStack(alignment: vm.imageUrl != nil ? .center : .leading, spacing: 6) {
                pretitle
                title
                ScrollView {
                    description
                    links
                    mapView
                }
                Spacer()
                ticketLink
                    .padding(.bottom, 15)
            }
            .padding(.horizontal, 14)
            Spacer()
        }
        .background {
            colorScheme == .light ? Color.white : Color.black
        }
        .fullScreenCover(isPresented: $showTicketLink, content: {
            if let urlString = vm.links?.tickets?.url,
               let url = URL(string: urlString) {
                SafariView(url: url)
            }
        })
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

    var pretitle: some View {
        vm.pretitleText.map {
            Text($0)
                .preTitleText(size: 14,
                              scheme: colorScheme)
        }
    }
    
    var title: some View {
        Text(vm.titleText)
            .titleText(size: 20,
            scheme: colorScheme)
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
                igLink
                if vm.links?.website != nil {
                    Spacer()
                }
                webLink
                Spacer()
            }
            .padding(.vertical, 5)
        }
    }
    
    var igLink: some View {
        vm.links?.instagram.map { igLink in
            Button {
//                TODO: link action
            } label: {
                if let imageName = igLink.image {
                    Label("\(igLink.title)",
                          systemImage: imageName )
                } else {
                    Text("\(igLink.title)")
                }
            }
        }
    }
    
    var webLink: some View {
        vm.links?.website.map { website in
            Button {
                //                TODO: link action
            } label: {
                if let imageName = website.image {
                    Label(website.title,
                          systemImage: imageName )
                } else {
                    Text(website.title)
                }
            }
        }
    }
    
    var ticketLink: some View {
        vm.links?.tickets.map { ticketLink in
            Text(ticketLink.title)
                .asLongButton {
                    showTicketLink = true
                }
        }
    }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        Text("Hello World")
    }
}
            
  

struct SafariView: UIViewControllerRepresentable {
    let url: URL

    func makeUIViewController(context: Context) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }

    func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {
        // Update the view controller if needed
    }
}

    


           
