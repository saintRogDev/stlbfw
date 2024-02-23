//
//  FullImageView.swift
//  STL BFW
//
//  Created by Roger Jones Jr on 10/25/23.
//

import SwiftUI

struct FullImageView: View {
    @Binding var imageName: String
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.black)
                .opacity(0.8)
                .ignoresSafeArea()
            VStack {
                Image(imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                Text("Tap to dismiss")
            }
            .onTapGesture {
                imageName = ""
            }
        }
    }
}

#Preview {
    FullImageView(imageName: .constant("desThe17"))
}
