//
//  LoadingView.swift
//  STL BFW
//
//  Created by Roger Jones Jr on 10/25/23.
//

import SwiftUI

struct LoadingView: View {
    var message: String? = nil
    
    init(message: String? = nil) {
        self.message = message
    }
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.black)
                .opacity(0.75)
                .ignoresSafeArea()
            ProgressView()
        }
    }
}

#Preview {
    LoadingView()
}
