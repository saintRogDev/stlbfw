//
//  DetailsView.swift
//  STL BFW
//
//  Created by Roger ADT on 9/23/23.
//

import MapKit
import SwiftUI

struct DetailsView: View {
    @Environment(\.colorScheme) var colorScheme
    @State var urlStringToShow: URL?
    @State var showInAppBrowser: Bool = false
    private let vm: DetailsViewViewModel

    init(category: DetailsViewViewModel.Category) {
        vm = DetailsViewViewModel(category: category)
    }

    var body: some View {
        VStack (spacing: 10) {
            header
            VStack (spacing: 10) {
                pretitle
                title
                if case .designer = vm.type {
                    links
                } else if case .event = vm.type {
                    ScrollView {
                        description
                        mapView
                        Spacer()
                    }
                    ticketLink
                } else if case .partner = vm .type {
                    links
                    description
                    mapView
                }
            }
            .padding(.horizontal, 15)
            if case .designer = vm.type {
                spreadView
            }
        }
        .background {
            colorScheme == .light ? Color.white : Color.black
        }
        .onChange(of: urlStringToShow) { newValue in
            if newValue != nil {
                showInAppBrowser = true
            }
        }
        .onChange(of: showInAppBrowser) { newValue in
            if showInAppBrowser == false  {
                self.urlStringToShow = nil
            }
        }
        .fullScreenCover(isPresented: $showInAppBrowser) {
            if let urlToShow = self.urlStringToShow {
                SafariView(url: urlToShow)
            }
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
                    if case .partner = vm.type {
                        vm.headerImage.map {
                            Image($0)
                                .clipped()
                        }
                    }
                }
                
            }
            .frame(maxHeight: 150)
            if case .designer = vm.type {
                vm.headerImage.map { headerImage in
                    ZStack {
                        Circle()
                            .frame(width: 100, height: 100)
                            .foregroundColor(.gray)
                        Image(headerImage)
                            .resizable()
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                    }
                    .padding(.top, -50)
                }
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
        vm.location.map { location in
            VStack {
                ZStack {
                    MapView(address: location.address)
                        .frame(width: 350, height: 200)
                        .clipShape(RoundedRectangle(cornerRadius: 8.0))
                        .padding(.top, 10)
                    if let name = location.name,
                       location.address.isEmpty == false  {
                        Text(name)
                            .preTitleText(size: 16, alignment: .center)
                    }
                }
                Text(location.address)
                    .detailsText(size: 12)
                    .padding(.leading, 5)
            }
        }
    }
    
    var spreadView: some View {
        ScrollView(.horizontal) {
            HStack(alignment: .top, spacing: 15) {
                ScrollView {
                    description
                        .frame(maxWidth: 250, maxHeight: .infinity)
                }
                .padding(.leading, 15)
                
                Divider()

                vm.imageUrl.map {
                    Image($0)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(maxWidth: 350)
                        .clipShape(RoundedRectangle(cornerRadius: 8.0))
                        .padding(.trailing, 15)
                }
            }
        }
    }
    
    var links: some View {
        HStack {
            igLink
            Spacer()
            webLink
        }
        .padding(.vertical, 5)
    }
    
    var igLink: some View {
        vm.links?.instagram.map { igLink in
            Button {
                if let url = URL(string: igLink.url) {
                    urlStringToShow = url
                }
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
                if let url = URL(string: website.url) {
                    urlStringToShow = url
                }
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
            VStack(spacing: 10) {
                Text(ticketLink.title)
                    .asLongButton {
                        if let url = URL(string: ticketLink.url) {
                            urlStringToShow = url
                        }
                    }
            }
            .padding(.bottom, 15)
        }
    }
    
    @ViewBuilder
    func showInAppBrowser(for _urlString: String?) -> some View {
        if let urlString = _urlString,
            let url = URL(string: urlString) {
            SafariView(url: url)
        }
        EmptyView()
    }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        Text("Hello World")
    }
}
           
