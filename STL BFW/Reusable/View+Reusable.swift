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
    
    func barButtonText() -> Text {
        self
            .font(.subheadline)
            .foregroundColor(.secondary)
            .fontWeight(.semibold)
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
                      scheme: ColorScheme = .light,
                      alignment: Alignment = .leading) -> some View {
        self.font(.subheadline)
            .foregroundColor(scheme == .light ? .black.opacity(0.6) : .secondary)
            .fontWeight(.semibold)
            .multilineTextAlignment(.leading)
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: alignment)
    }

    func titleText(size: CGFloat, 
                   alignment: Alignment = .leading,
                   scheme: ColorScheme = .light) -> some View  {
        self.font(.headline)
            .fixedSize(horizontal: false, vertical: true)
            .foregroundColor(scheme == .light ? .black : .primary)
            .multilineTextAlignment(.leading)
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: alignment)

    }

    func detailsText(size: CGFloat,
                     alignment: Alignment = .leading,
                     scheme: ColorScheme = .dark) -> some View {
        self.font(.callout)
            .foregroundColor(scheme == .light ? .black.opacity(0.6) : .secondary)
            .multilineTextAlignment(.leading)
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

    func bordered(scheme: ColorScheme? = .light) -> some View {
        return self
            .background {
                RoundedRectangle(cornerRadius: 8)
                    .fill(scheme == .light ? Color.white : Color.black)
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
                    .titleText(size: 14, scheme: .dark)
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
    
    func loadingView(message: Binding<String>) -> some View {
        ZStack {
            self
            if !message.wrappedValue.isEmpty {
                LoadingView(message: message.wrappedValue)
            }
        }
    }
    
    func fullImageView(image: Binding<String>) -> some View  {
        self
            .overlay(alignment: .center, content: {
                if !image.wrappedValue.isEmpty {
                    FullImageView(imageName: image)
                }
                
            })
    }
    
    
}


extension Image {
    func showFullImage() {
        
    }
}

extension Date {
    static func convertToDate(_ dateString: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy MMMM d h:mm a"
        return dateFormatter.date(from: "2023 ".appending(dateString))
    }
}
