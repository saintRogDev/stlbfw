//
//  CheckBoxView.swift
//  STL BFW
//
//  Created by Roger ADT on 9/30/23.
//

import SwiftUI

struct CheckBoxView: View {
    @Binding var isChecked: Bool

    var body: some View {
        Button(action: {
            isChecked.toggle()
        }) {
            Image(systemName: isChecked ? "checkmark.square" : "square")
                .resizable()
                .frame(width: 24, height: 24)
                .foregroundColor(isChecked ? .white : .gray)
        }
    }
}

#Preview {
    CheckBoxView(isChecked: .constant(false))
}
