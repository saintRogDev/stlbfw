//
//  FullImageView.swift
//  STL BFW
//
//  Created by Roger Jones Jr on 10/25/23.
//

import SwiftUI

struct FullImageView: View {
    @Binding var imageName: String
//    @State private var scale: CGFloat = 1.0
    
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
//                    .scaleEffect(scale)
//                    .gesture(
//                        MagnificationGesture()
//                            .onChanged { gestureScale in
//                                self.scale = gestureScale
//                            }
//                    )
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
