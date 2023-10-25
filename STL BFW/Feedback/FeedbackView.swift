//
//  FeedbackView.swift
//  STL BFW
//
//  Created by Roger ADT on 9/30/23.
//

import StoreKit
import SwiftUI

struct FeedbackView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var vm = FeedbackViewModel()


    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            HStack {
                Button(action: { dismiss() }, label: {
                    Text("Cancel")
                })
                Spacer()
            }
            .padding(.top, 10)
            .padding(.leading, 10)
            Text("Submit Feedback")
                .titleText(size: 20, alignment: .center, scheme: .dark)
            ScrollView {
                VStack(spacing: 20) {
                    Text("Thanks for submitting feedback to the Saint Louis Black Fashion Week Team. We pride ourselves on taking the time to read and consider all feedback and concerns. Though we cannot respond to everyone, we want you to know that we appreciate your investment into our company.")
                    textField(title: "Name",
                              isRequired: true,
                              text: $vm.feedback.name)
                    textField(title: "Email",
                              isRequired: true,
                              text: $vm.feedback.email)
                    rate
                    comment
                    contactMeCard
                    submitButton
                }
                .padding(.bottom, 15)
            }
        }
        .padding(.horizontal, 10)
        .alert(vm.statusString ?? "Unknown Error",
               isPresented: $vm.showAlert,
               actions: {
            Button("OK", role: .cancel) { }
        })
        .loadingView(message: $vm.loading)
        .onChange(of: vm.response, perform: { value in
            if case .success = vm.response {
                dismiss()
            }
        })
    }

    func textField(title: String,
                   isRequired: Bool,
                   text: Binding<String>) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            TextField("", text: text)
                .frame(height: 40)
                .padding(.horizontal, 5)
                .bordered(scheme: .dark)
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
                        .preTitleText(size: 14, scheme:.dark)
                    Text("Check this box if you would like to be contacted about the feedback you have submitted.")
                        .detailsText(size: 14, scheme: .dark)
                }
            }
        }
        .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
        .bordered(scheme: .dark)
    }

    var rate: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Tell us how we did!")
                    .detailsText(size: 14)
            }
            HStack {
                HStack {
                    ForEach(1 ..< 6) { star in
                        Image(systemName: star <= vm.feedback.rating ? "star.fill" : "star")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundColor(star <= vm.feedback.rating ? .white : .gray)
                            .onTapGesture {
                                vm.feedback.rating = star
                            }
                    }
                }
            }
        }
        .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
        .bordered(scheme: .dark)
        .titled("Your Rating", secondary: "Required")
    }

    var comment: some View {
        TextEditor(text: $vm.feedback.comment)
            .colorMultiply(.white)
            .frame(height: 100)
            .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
            .bordered(scheme: .dark)
            .titled("Comment", secondary: "Required")
    }

    var submitButton: some View {
        Button {
            vm.submitButtonTap()
        } label: {
            HStack{
                Text("Submit")
                    .foregroundColor(.black)
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
