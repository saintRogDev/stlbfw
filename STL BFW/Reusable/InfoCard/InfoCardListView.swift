//
//  ListView.swift
//  STL BFW
//
//  Created by Roger ADT on 9/18/23.
//

import SwiftUI

struct InfoCardListViewModel {
    enum Category {
        case events
        case designers
        case partners

        var title: String {
            switch self {
            case .designers:
                return "Designers"
            case .events:
                return "Events"
            case .partners:
                return "Partners"
            }
        }
    }

    let category: Category
    let infoCards: [InfoCardModel]

    init(category: Category) {
        infoCards = InfoCardListViewModel.infoCardModels(category: category)
        self.category = category
    }

    static func infoCardModels(category: InfoCardListViewModel.Category) -> [InfoCardModel] {
        switch category {
        case .designers:
            return Designer.designers.map {
                $0.infoCardModel
            }
        case .events:
            return Event.events.map {
                $0.infoCardModel
            }

        case .partners:
            return Partner.Partners.map {
                $0.infoCardModel
            }
        }
    }
}

struct InfoCardListView: View {
    @Environment(\.colorScheme) var colorScheme
    @State var selected: InfoCardModel?
    let vm: InfoCardListViewModel

    init(category: InfoCardListViewModel.Category) {
        vm = InfoCardListViewModel(category: category)
    }


    var body: some View {
        VStack(alignment: .leading) {
            title
                .padding(.horizontal, 10)

            list
                .frame(maxWidth: .infinity)
                .standardBackground(scheme: colorScheme)

        }

    }

    var title: some View  {
        Text(self.vm.category.title)
            .titleText(size: 28,
                       scheme: colorScheme)
    }

    var list: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 15) {
                ForEach(0..<vm.infoCards.count, id: \.self) { i in
                    if i % 2 == 0  {
                        let infoCardList = horizontalListItems(index: i)
                        HStack(alignment: .top, spacing: 20) {
                            ForEach(0..<infoCardList.count, id: \.self) { i in
                                let cardModel = infoCardList[i]
                                InfoCard(model: cardModel)
                            }
                        }
                    }
                }
            }
            .padding(.vertical, 10)
        }
    }

    func horizontalListItems(index: Int) -> [InfoCardModel] {
        let list = vm.infoCards
        var models = [list[index]]
        if list.count > index + 1 {
            models.append(list[index + 1])
        }
        return models
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        InfoCardListView(category: .events)
    }
}
