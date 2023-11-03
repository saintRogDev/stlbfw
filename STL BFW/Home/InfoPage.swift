//
//  InfoPage.swift
//  STL BFW
//
//  Created by Roger ADT on 9/30/23.
//

import SwiftUI


struct InfoPageViewModel {
    var partnerCardModel: [InfoCardModel] = Partner.Partners.map { $0.infoCardModel }
}

struct InfoPage: View {
    @Environment(\.colorScheme) var colorScheme
    let vm: InfoPageViewModel
    @State private var showMailView: Bool = false
    @State private var showFeedback: Bool = false


    var body: some View {
        HeaderView(title: "Information") {
            VStack(spacing: 10) {
                details
                partners
                feedbackCard
                contact
            }
            .sheet(isPresented: $showFeedback, content: { FeedbackView() })
        }
        .sheet(isPresented: Binding(get: {
            showMailView && MFMailComposeViewController.canSendMail() == true
        }, set: { value in
            showMailView = value
        })) {
            MailComposeViewController(isShowing: self.$showMailView)
        }
    }

    private var details: some View {
        Text(kStlBfwInfo)
            .detailsText(size: 14,
                         scheme: colorScheme)

    }

    private var partners: some View {
        HorizontalScrollView(title: "Partners",
                             infoCardList: vm.partnerCardModel,
                             seeAllSelected: nil)
    }

    private var contact: some View {
        Text("Contact")
            .asLongButton(imageName: "envelope",
                          action: {
                showMailView = true
            })
    }

    private var feedbackCard: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Feedback")
                .titleText(size: 16)
            Text("If you have feedback about this year's Saint Louis Black Fashion Week please submit a form below detailing your thoughts, or reach out to us on instagram @stlbfw")
                .detailsText(size: 14)
            VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, content: {
                Button {
                    showFeedback = true
                } label: {
                    HStack{
                        Image(systemName: "square.and.pencil")
                        Text("Submit feedback")
                    }
                    .foregroundColor(.black)
                    .padding(.vertical, 10)
                    .frame(maxWidth: .infinity)
                    .bordered()
                }
            })
        }
        .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
        .bordered()

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
