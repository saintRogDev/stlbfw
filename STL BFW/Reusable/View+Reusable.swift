//
//  ResuableViews.swift
//  STL BFW
//
//  Created by Roger ADT on 9/19/23.
//

import SwiftUI

extension Text {
    func title() -> some View {
        self.fontWeight(.bold)
    }

    func headingFont(size: CGFloat) -> Text {
        self.font(Font.custom("Copperplate Light", size: size))
    }

    func headingText(size: CGFloat) -> some View {
        self.headingFont(size: size)
            .fixedSize(horizontal: false, vertical: true)
            .foregroundColor(.white)
            .multilineTextAlignment(.center)
    }

    func preTitleText(size: CGFloat,
                      scheme: ColorScheme = .light) -> some View {
        self.font(.system(size: size))
            .foregroundColor(scheme == .light ? .black.opacity(0.6) : .secondary)
            .fontWeight(.semibold)
            .multilineTextAlignment(.leading)
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
    }

    func titleText(size: CGFloat, 
                   alignment: Alignment = .leading,
                   scheme: ColorScheme = .light) -> some View  {
        self.font(.system(size: size))
            .fixedSize(horizontal: false, vertical: true)
            .foregroundColor(scheme == .light ? .black : .primary)
            .fontWeight(.semibold)
            .multilineTextAlignment(.leading)
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: alignment)

    }

    func detailsText(size: CGFloat,
                     textAlignment: TextAlignment = .leading,
                     alignment: Alignment = .leading,
                     scheme: ColorScheme = .light) -> some View {
        self.font(.system(size: size))
            .foregroundColor(scheme == .light ? .black.opacity(0.6) : .secondary)
            .multilineTextAlignment(textAlignment)
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: alignment)

    }
    
    func asLongButton(imageName: String? = nil,
                      action: @escaping () -> Void) -> some View {
        Button {
            action()
        } label: {
            HStack{
                if let image = imageName {
                    Image(systemName: image)
                }
                self
            }
            .foregroundColor(.black)
            .padding(.vertical, 10)
            .frame(maxWidth: .infinity)
            .bordered()
        }
    }
}

extension View {
    func detailSheet(detailCategory: Binding<DetailsViewViewModel.Category?>) -> some View  {
        return self
            .sheet(item: detailCategory) { category in
                DetailsView(category: category)
            }
    }

    func bordered() -> some View {
        return self
            .background {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray, lineWidth: 1)
                    )
            }
    }

    func standardBackground(scheme: ColorScheme) -> some View  {
        self
        .background {
            if scheme == .light {
                Color(.secondarySystemBackground)
                    .ignoresSafeArea()
            }
        }
    }

    func titled(_ title: String, secondary: String? = nil)  -> some View {
        VStack(spacing: 10) {
            HStack {
                Text(title)
                    .titleText(size: 14)
                Spacer()
                secondary.map {
                    Text($0)
                        .detailsText(size: 14, alignment: .trailing)
                }
            }
            .padding(.horizontal, 5)
            self
        }
    }
}

extension Date {
    static func convertToDate(_ dateString: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy MMMM d h:mm a"
        return dateFormatter.date(from: "2023 ".appending(dateString))
    }
}
