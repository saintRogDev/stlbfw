//
//  HorizontalScrollView.swift
//  STL BFW
//
//  Created by Roger ADT on 9/19/23.
//

import SwiftUI

struct HorizontalScrollView: View {
    let title: String?
    let infoCardList: [InfoCardModel]
    let seeAllSelected: ((InfoCardModel.Category)->Void)?

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            title.map { title in
                header(text: title)
            }
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: infoCardList.count > 2 ? 10 : 15) {
                    ForEach(0..<infoCardList.count, id: \.self) { i in
                        let cardModel = infoCardList[i]
                        InfoCard(model: cardModel)
                    }
                }
            }
            .scrollDisabled(infoCardList.count < 3)
        }
    }

    @ViewBuilder
    func header(text: String) -> some View {
        HStack(alignment: .bottom) {
            Text(text)
                .foregroundColor(.primary)
                .font(.largeTitle)
                .fontWeight(.bold)
            Spacer()
            seeAllSelected.map { seeAll in
                Button {
                    if let card = infoCardList.first {
                        seeAll(card.type)
                    }
                } label: {
                    HStack (spacing: 0) {
                        Text("See All  ")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundColor(Color.gray)
                        Image(systemName: "chevron.right")
                            .foregroundColor(Color.gray)
                    }
                }
            }
        }
    }
}

struct HorizontalScrollView_Previews: PreviewProvider {
    static var previews: some View {
       Text("Hello World")
    }
}
