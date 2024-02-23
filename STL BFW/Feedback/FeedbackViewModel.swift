//
//  FeedbackViewModel.swift
//  STL BFW
//
//  Created by Roger Jones Jr on 10/25/23.
//

import Foundation

struct Feedback: Codable {
    var name: String = ""
    var email: String = ""
    var comment: String = ""
    var contactRequested: Bool = false
    var rating: Int = 0
}

class FeedbackViewModel: ObservableObject {
    enum Response: Equatable {
        case success
        case failure(String)
    }
    
    @Published var feedback = Feedback()
    @Published var response: Response? = nil
    
    @Published var statusString: String? {
        didSet {
            showAlert = statusString != nil
        }
    }
    
    @Published var showAlert: Bool = false
    @Published var loading: String = ""
    
    private var service: Networking
    
    // Dependancy injection for tesability
    init(_ service: Networking? = nil) {
        if let service = service {
            self.service = service
        } else {
            self.service = Service.shared
        }
    }
    
    private func isValid(_ feeedback: Feedback) -> Bool {
        return !feedback.name.isEmpty && !feedback.comment.isEmpty && feedback.rating > 0 && isValidEmail(feedback.email)
    }

    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }

    func submitButtonTap() async {
        if isValid(feedback) {
            loading = "Submitting feedback..."
            Task.init {
                do {
                    let response: Feedback? = try await service.post(from: "/data/Feedback",
                                                                     body: feedback)
                    if response != nil {
                        self.response = .success
                        loading = ""
                        statusString = "Thank you for your feedback."
                    }
                } catch {
                    statusString = "There was an error submitting your feedback. Please try again later."
                    loading = ""
                }
            }
        } else {
            statusString = "Please complete required areas, and check that you have submitted a valid email address."
        }
    }
}
