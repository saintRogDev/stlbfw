//
//  STL_BFWApp.swift
//  STL BFW
//
//  Created by Roger ADT on 9/13/23.
//

import SwiftUI

@main
struct STL_BFWApp: App {
    @State var tabSelection = 0

    init() {
        UITabBar.appearance().backgroundColor = UIColor(.white)
    }

    var body: some Scene {
        WindowGroup {
            TabView(selection: $tabSelection) {
                Home(tabSelection: $tabSelection)
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
        }
    }
}
