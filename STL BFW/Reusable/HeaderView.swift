//
//  HeaderView.swift
//  STL BFW
//
//  Created by Roger ADT on 9/30/23.
//

import SwiftUI

struct HeaderView<Conent: View>: View {
    @Environment(\.colorScheme) var colorScheme
    let title: String
    let content: () -> Conent

    var body: some View {
        NavigationView {
            VStack {
                Text(title)
                    .title()
                headerWithContent
            }
        }
    }

    private var headerWithContent: some View {
        VStack(spacing: 0) {
            ScrollView() {
                VStack(spacing: 20) {
                    Image("Banner23")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    content()
                }
                .padding(.bottom, 15)
            }
            .frame(maxWidth: .infinity)
        }
        .standardBackground(scheme: colorScheme)
    }
}

#Preview {
    HeaderView(title: "Empty", content:{ EmptyView() })
}
