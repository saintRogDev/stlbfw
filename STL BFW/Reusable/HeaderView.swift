//
//  HeaderView.swift
//  STL BFW
//
//  Created by Roger ADT on 9/30/23.
//

import SwiftUI

struct HeaderView<Conent: View>: View {
    @Environment(\.colorScheme) var colorScheme
    @State var selectedImage: String = ""
    let title: String
    let content: () -> Conent
    
    
    var body: some View {
        VStack {
            Text(title)
                .title()
            headerWithContent
        }
        .fullImageView(image: $selectedImage)
    }

    private var headerWithContent: some View {
        VStack(spacing: 0) {
            ScrollView() {
                VStack(spacing: 20) {
                    Image("Banner23")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .onTapGesture {
                            self.selectedImage = "Banner23"
                        }
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
