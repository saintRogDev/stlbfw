//
//  HorizontalScrollView.swift
//  STL BFW
//
//  Created by Roger ADT on 9/19/23.
//

import SwiftUI

final class HorizontalScrollViewModel: ObservableObject {
    let title: String?
    @Published var infoCardList: [InfoCardModel]
    let seeAllSelected: ((InfoCardModel.Category)->Void)?
    let shouldScroll: Bool
    @Published var scrollToID: Int = 0

    init(title: String?,
         infoCardList: [InfoCardModel],
         shouldScroll: Bool, 
         seeAllSelected: ((InfoCardModel.Category) -> Void)?) {
        self.shouldScroll = shouldScroll
        self.title = title
        self.infoCardList = infoCardList
        self.seeAllSelected = seeAllSelected
    }
    
    
    func cardModel(for _index: Int) -> InfoCardModel? {
        let cardModel = infoCardList[_index]
        if shouldScroll == true && scrollToID == 0 {
            switch cardModel.type {
            case .event(let event):
                guard let eventDate = Date.convertToDate(event.date) else { break }
                if eventDate < Date() {
                    scrollToID = _index
                }
            default:
                break
            }
        }
        return cardModel
    }
}

struct HorizontalScrollView: View {
    @ObservedObject var vm: HorizontalScrollViewModel
    @State private var scrollProxy: ScrollViewProxy? = nil
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            vm.title.map { title in
                header(text: title)
                    .padding(.horizontal, 10)
            }
            ScrollViewReader { scrollView in
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(alignment: .top, spacing: vm.infoCardList.count > 2 ? 10 : 15) {
                        ForEach(0..<vm.infoCardList.count, id: \.self) { i in
                            if let cardModel = vm.cardModel(for: i) {
                                InfoCard(model: cardModel)
                            }
                        }
                    }
                    .padding(.horizontal, 10)
                    .onAppear {
                        let id = vm.scrollToID
                        scrollView.scrollTo(id)
                    }
                }
//                .scrollDisabled(vm.infoCardList.count < 3)
            }
        }
    }
    
    
    func header(text: String) -> some View {
        return HStack(alignment: .bottom) {
            Text(text)
                .foregroundColor(.primary)
                .font(.largeTitle)
                .fontWeight(.bold)
            Spacer()
            vm.seeAllSelected.map { seeAll in
                Button {
                    if let card = vm.infoCardList.first {
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
