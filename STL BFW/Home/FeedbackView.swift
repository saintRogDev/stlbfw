//
//  FeedbackView.swift
//  STL BFW
//
//  Created by Roger ADT on 9/30/23.
//

import SwiftUI

struct Feedback: Codable {
    var name: String = ""
    var email: String = ""
    var comment: String = ""
    var contactRequested: Bool = false
    var rating: Int = 0

    var isValid: Bool {
        return !name.isEmpty && !comment.isEmpty && rating > 0 && isValidEmail(email)
    }

    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#

        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
}

class FeedbackViewModel: ObservableObject {
    @Published var feedback = Feedback()

    func submitButtonTap() {
        Task.init {
            do {
                let response: Feedback? = try await Networking.shared.post(from: "/data/Feedback",
                                                                           body: feedback)
                if let response = response {
                    print(response)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }


}

struct FeedbackView: View {
    @StateObject var vm = FeedbackViewModel()


    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            Text("Submit Feedback")
                .titleText(size: 20, alignment: .center)
                .padding(.top, 10)
            ScrollView {
                VStack(spacing: 20) {
                    Text("Thanks for submitting feedback to the Saint Louis Black Fashion Week Team. We pride ourselves on taking the time to read and consider all feedback and concerns. Though we cannot respond to everyone, we want you to know that we appreciate your investment into our company.")
                    textField(title: "Name",
                              isRequired: true,
                              text: $vm.feedback.name)
                    textField(title: "Email",
                              isRequired: true,
                              text: $vm.feedback.email)
                    contactMeCard
                    rate
                    comment
                    submitButton
                }
                .padding(.bottom, 15)
            }
        }
        .padding(.horizontal, 10)
//        .standardBackground()
        
    }

    func textField(title: String,
                    isRequired: Bool,
                    text: Binding<String>) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            TextField("", text: text)
            .frame(height: 40)
            .padding(.horizontal, 5)
            .bordered()
            .titled(title, secondary: "Required")
        }
        .frame(maxWidth: .infinity)
    }

    var contactMeCard: some View {
        VStack {
            HStack(alignment:.top) {
                CheckBoxView(isChecked: $vm.feedback.contactRequested)
                VStack(alignment: .leading) {
                    Text("Please contact me")
                    Text("Check this box if you would like to be contacted about the feedback you have submitted.")
                        .detailsText(size: 14)
                }
            }
        }
        .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
        .bordered()
    }

    var rate: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Tell us how we did!")
                    .detailsText(size: 14)
                Text("Your rating")
            }
            HStack {
                HStack {
                    ForEach(1 ..< 6) { star in
                        Image(systemName: star <= vm.feedback.rating ? "star.fill" : "star")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundColor(star <= vm.feedback.rating ? .black : .gray)
                            .onTapGesture {
                                vm.feedback.rating = star
                            }
                    }
                }
            }
        }
    }

    var comment: some View {
        TextEditor(text: $vm.feedback.comment)
            .frame(height: 100)
            .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
            .bordered()
            .titled("Comment", secondary: "Required")
    }

    var submitButton: some View {
        Button {
            vm.submitButtonTap()
        } label: {
            HStack{
                Text("Submit")
            }
            .padding(.vertical, 10)
            .frame(maxWidth: .infinity)
            .bordered()
            .padding(.horizontal, 20)
        }
    }
}

#Preview {
    FeedbackView()
}
