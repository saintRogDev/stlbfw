//
//  InfoPage.swift
//  STL BFW
//
//  Created by Roger ADT on 9/30/23.
//

import SwiftUI
import UniformTypeIdentifiers

struct InfoPageViewModel {
    var partnerCardModel: [InfoCardModel] = Partner.Partners.map { $0.infoCardModel }
}

struct InfoPage: View {
    @Environment(\.colorScheme) var colorScheme
    let vm: InfoPageViewModel
    @State private var showMailView: Bool = false
    @State private var showAlert: Bool = false
    @State private var showFeedback: Bool = false
    @State private var showInAppBrowser: Bool = false
    @State private var showSite: Bool = false


    var body: some View {
        HeaderView(title: "Information") {
            VStack(spacing: 10) {
                details
                partners
                feedbackCard
                contact
                appfFeedback
                Spacer()
                Text("Visit Our Website")
                    .underline()
                    .onTapGesture {
                        showSite = true
                    }
                Spacer()
            }
            .sheet(isPresented: $showFeedback, content: { FeedbackView() })
        }
        .sheet(isPresented: $showMailView, content: {
            MailComposeViewController(isShowing: self.$showMailView)
        })
        .alert("Contact Email connect@stlbfw.com has been coppied to your clipboard", isPresented: $showAlert, actions: {
            Button("OK", role: .cancel) { }
        })
        .fullScreenCover(isPresented: $showInAppBrowser) {
            if let url = URL(string: "https://docs.google.com/forms/d/e/1FAIpQLSdFSQ3izzBgzoQxOwzGk_-HEqktvY2kRvkqYMygMG1BeYXEBA/viewform?pli=1") {
                SafariView(url: url)
            }
        }
        .fullScreenCover(isPresented: $showSite) {
            if let url = URL(string: "https://www.stlbfw.com/history") {
                SafariView(url: url)
            }
        }
        
    }

    private var details: some View {
        Text(kStlBfwInfo)
            .detailsText(size: 14,
                         scheme: colorScheme)
            .padding(.horizontal, 10)

    }

    private var partners: some View {
        VStack(spacing: 0) {
            Text("Partners")
                .titleText(size: 20, scheme: .dark)
            ScrollView(.horizontal) {
                Image("partners")
            }
        }
    }

    private var contact: some View {
        Text("Contact")
            .asLongButton {
                if MFMailComposeViewController.canSendMail() == true  {
                    showMailView = true
                } else {
                    UIPasteboard.general.setValue("connect@stlbfw.com",
                                                  forPasteboardType: UTType.plainText.identifier)
                    showAlert = true
                }
            }
            .padding(.horizontal, 10)
    }

    
    private var appfFeedback: some View {
        Text("App Feedback")
            .asLongButton(imageName: "square.and.pencil",
                          action: {
                showFeedback = true
            })
            .padding(.horizontal, 10)
    }

    private var feedbackCard: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Feedback")
                .titleText(size: 16)
            Text("If you have feedback about this year's Saint Louis Black Fashion Week please submit a form below detailing your thoughts, or reach out to us on instagram @stlbfw")
                .detailsText(size: 14, scheme: .light)
            VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, content: {
                Button {
                    showInAppBrowser = true
                } label: {
                    HStack{
                        Image(systemName: "square.and.pencil")
                        Text("Submit feedback")
                            .underline()
                    }
                    .foregroundColor(.black)
                    .padding(.vertical, 10)
                    .frame(maxWidth: .infinity)
                }
            })
        }
        .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
        .bordered()
        .padding(.horizontal, 10)

    }

}

#Preview {
    InfoPage(vm: InfoPageViewModel())
}

import MessageUI

struct MailComposeViewController: UIViewControllerRepresentable {

    @Binding var isShowing: Bool

    func makeUIViewController(context: Context) -> MFMailComposeViewController {
        let mailComposer = MFMailComposeViewController()
        mailComposer.mailComposeDelegate = context.coordinator
        mailComposer.setToRecipients(["connect@stlbfw.com"])
        mailComposer.setSubject("Contact: STL BFW")
        return mailComposer
    }

    func updateUIViewController(_ uiViewController: MFMailComposeViewController, context: Context) {
        // No need to update the view controller
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(isShowing: $isShowing)
    }

    class Coordinator: NSObject, MFMailComposeViewControllerDelegate {
        @Binding var isShowing: Bool

        init(isShowing: Binding<Bool>) {
            _isShowing = isShowing
        }

        func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
            // Handle the result of the email composition here
            isShowing = false
        }
    }
}
