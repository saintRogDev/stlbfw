//
//  DetailsView.swift
//  STL BFW
//
//  Created by Roger ADT on 9/23/23.
//

import Combine
import MapKit
import SwiftUI

struct DetailsView: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.dismiss) var dismiss
    @State var urlStringToShow: URL?
    @State var showInAppBrowser: Bool = false
    @State var showFullImage: Bool = false
    @ObservedObject var vm: DetailsViewViewModel
    
    init(category: DetailsViewViewModel.Category) {
        vm = DetailsViewViewModel(category: category)
    }
    
    var body: some View {
        VStack (spacing: 10) {
            header
            VStack (spacing: 10) {
                pretitle
                if vm.showPersonalLink() {
                    titlePlus
                } else {
                    title
                }
                if case .designer = vm.type {
                    links
                } else if case .event = vm.type {
                    ScrollView {
                        description
                        mapView
                        Spacer()
                    }
                    ticketLink
                }
            }
            .padding(.horizontal, 15)
            if case .designer = vm.type {
                spreadView
            }
        }
        .fullImageView(image: $vm.fullImage)
        .background {
            colorScheme == .light ? Color.white.ignoresSafeArea() : Color.black
                .ignoresSafeArea()
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
        ZStack(alignment: .top) {
            Color(.black)
                .frame(maxWidth: .infinity,
                       maxHeight: vm.type.isEvent ? 150 : 200)
            VStack(spacing: 0) {
                
                vm.headerText.map {
                    Text($0)
                        .headingText(size: 35)
                        .padding(.horizontal, 20)
                }
                .overlay(content: {
                    if case .event = vm.type  {
                        vm.headerImage.map { img in
                            Image(img)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                        }
                    } else {
                        EmptyView()
                    }
                })
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
                                .onTapGesture {
                                    vm.imageSelected(image: headerImage)
                                    showFullImage = true
                                }
                        }
                    }
                }
            }
            .padding(.top, 70)
            HStack {
                Button(action: {
                    dismiss()
                }, label: {
                    Text("Done")
                        .barButtonText()
                })
                Spacer()
//
//                Button(action: {
//                    vm.loadNext(category: vm.type)
//                }, label: {
//                    Text("Next")
//                        .barButtonText()
//                })
            }
            .padding(.top, 10 )
            .padding(.horizontal, 15)
        }
    }
    
    var pretitle: some View {
        vm.pretitleText.map {
            Text($0)
                .preTitleText(size: 14,
                              scheme: colorScheme)
        }
    }
    
    var titlePlus: some View {
        Text(vm.titleText)
            .underline()
            .titleText(size: 20,
                       scheme: colorScheme)
            .onTapGesture {
                switch vm.type {
                case .designer(let designer):
                    if let designerIg = designer.personalIg,
                       let url = URL(string: designerIg) {
                        urlStringToShow = url
                    }
                default:
                    break
                }
                
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
                             scheme: colorScheme)
        }
    }
    
    var mapView: some View {
        vm.location.map { location in
            MapView(address: location.address,
                    name: location.name)
            .frame(width: 350, height: 265)
        }
    }
    
    var spreadView: some View {
        ScrollView(.horizontal) {
            HStack(alignment: .top, spacing: 8) {
                ScrollView {
                    description
                        .frame(maxWidth: 250, maxHeight: .infinity)
                }
                .padding(.leading, 15)
                Spacer()
                Divider()
                    .foregroundColor(.primary)
                Spacer()
                vm.imageUrl.map { image in
                    Image(image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(maxWidth: 350)
                        .clipShape(RoundedRectangle(cornerRadius: 8.0))
                        .padding(.trailing, 15)
                        .onTapGesture {
                            vm.imageSelected(image: image)
                            showFullImage = true
                        }
                }
            }
        }
    }
    
    var links: some View {
        HStack {
            igLink
            Divider()
                .frame(width: 2, height: 12)
            webLink
            Spacer()
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

