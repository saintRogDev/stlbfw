//
//  HomeCell.swift
//  STL BFW
//
//  Created by Roger ADT on 9/16/23.
//

import Foundation
import SwiftUI

protocol Cardable {
    var infoCardModel: InfoCardModel { get }
}

struct InfoCardModel: Identifiable {
    indirect enum Category {
        case designer(Designer)
        case event(Event)
        case partner(Partner)

        var isEvent: Bool {
            if case .event(_) = self {
                return true
            }
            return false

        }
    }

    let id: UUID
    let headerText: String?
    let headerImageName: String?
    let pretitleText: String?
    let titleText: String
//    let descriptionText: String? = "Tap to Explore"
    let type: Category
}

struct InfoCard: View {
    @State var model: InfoCardModel
    @State var showDetial: DetailsViewViewModel.Category?

    var body: some View {
            VStack(spacing: 10) {
                heading
                info
                Spacer()
            }
            .padding(EdgeInsets(top: 8, leading: 5, bottom: 0, trailing: 5))
            .bordered()
            .detailSheet(detailCategory: $showDetial)
            .onTapGesture {
                switch model.type {
                case .designer(let designer):
                    showDetial = .designer(designer)
                case .event(let event):
                    showDetial = .event(event)
                case .partner(let partner):
                    showDetial = .partner(partner)
                }
            }
    }
    

    var heading: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .foregroundColor(.black)
                .frame(width: 160, height: 160)
            model.headerText.map {
                Text($0)
                    .headingText(size: 15)
                    .frame(maxWidth: 140)
                    .overlay {
                        model.headerImageName.map {
                            Image($0)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                        }
                    }
            }
        }
    }

    var info: some View {
        VStack(alignment: .leading) {
            model.pretitleText.map {
                Text($0)
                    .preTitleText(size: 13)
            }
            Text(model.titleText)
                .titleText(size: 16)
//            Text(model.descriptionText)
//                .detailsText(size: 14)
        }
        .frame(width: 140)
    }
}

struct InfoCard_Previews: PreviewProvider {
    static var previews: some View {
//        InfoCard()
        Text("Hello World")
    }
}
