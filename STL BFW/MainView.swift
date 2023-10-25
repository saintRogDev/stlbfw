//
//  MainView.swift
//  STL BFW
//
//  Created by Roger Jones Jr on 10/21/23.
//

import SwiftUI

struct MainView: View {
    @Environment(\.colorScheme) var colorScheme
    @State var tabSelection = 0

    var body: some View {
        TabView(selection: $tabSelection) {
            HomeView(tabSelection: $tabSelection)
                .tabItem {
                    Label("Home", systemImage: "house")
                }
                .foregroundStyle(Color.gray)
                .tag(0)

            InfoCardListView(category: .events)
                .tabItem {
                    Label("Events", systemImage: "calendar")
                }
                .tag(1)
            InfoCardListView(category: .designers)
                .tabItem {
                    Label("Designers", systemImage: "person.2.circle")
                }
                .tag(2)
            InfoPage(vm: InfoPageViewModel())
                .tabItem {
                    Label("Info", systemImage: "info.circle")
                }
                .tag(3)
        }
        .tint(.primary)
        .onChange(of: colorScheme, perform: { newValue in
            if newValue == .light {
                UITabBar.appearance().backgroundColor = UIColor(.white)
            } else  {
                UITabBar.appearance().backgroundColor = UIColor(.black)
            }
        })
        .onAppear {
            UITabBar.appearance().backgroundColor = UIColor(.black)
        }
    }
}

#Preview {
    MainView()
}
