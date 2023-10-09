//
//  ContentView.swift
//  STL BFW
//
//  Created by Roger ADT on 9/13/23.
//

import SwiftUI

struct Home: View {
    @Binding var tabSelection: Int

    var body: some View {
        HeaderView(title: "Home") {
            mainContent
        }
    }

    private var mainContent: some View {
        VStack {
            HorizontalScrollView(title: InfoCardListViewModel.Category.events.title,
                                 infoCardList: InfoCardListViewModel.infoCardModels(category: .events),
                                 seeAllSelected: seeAllSelected)
            HorizontalScrollView(title: InfoCardListViewModel.Category.designers.title,
                                 infoCardList: InfoCardListViewModel.infoCardModels(category: .designers),
                                 seeAllSelected: seeAllSelected)
        }
    }


    private func seeAllSelected(category: InfoCardModel.Category) {
        switch category {
        case .event(_):
            tabSelection = 1
        case .designer(_):
            tabSelection = 2
        default:
            return 
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home(tabSelection: .constant(0))
    }
}

