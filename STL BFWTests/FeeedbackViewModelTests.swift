//
//  FeeedbackViewModelTests.swift
//  STL BFWTests
//
//  Created by Roger Jones Jr on 2/22/24.
//

@testable import STL_BFW

import XCTest

final class FeeedbackViewModelTests: XCTestCase {
    var mockService = MockService()

    func testErrorStatusIsSetWhenFeedbackIsEmpty() async {
        let mockService = MockService()
        let testObject = FeedbackViewModel(mockService)
        await testObject.submitButtonTap()
        XCTAssertEqual(testObject.statusString, "Please complete required areas, and check that you have submitted a valid email address.")
        XCTAssertEqual(mockService.postCount, 0)
    }
    
    func testErrorStatusIsSetWhenFeedbackIsMissingName() async {
        let mockService = MockService()
        let testObject = FeedbackViewModel(mockService)
        testObject.feedback.comment = "some comment"
        testObject.feedback.rating = 5
        testObject.feedback.email = "valid@email.com"
        await testObject.submitButtonTap()
        XCTAssertEqual(testObject.statusString, "Please complete required areas, and check that you have submitted a valid email address.")
        XCTAssertEqual(mockService.postCount, 0)
    }
    
    func testErrorStatusIsSetWhenFeedbackIsMissingRating() async {
        let mockService = MockService()
        let testObject = FeedbackViewModel(mockService)
        testObject.feedback.name = "Some Name"
        testObject.feedback.comment = "some comment"
        testObject.feedback.email = "valid@email.com"
        await testObject.submitButtonTap()
        XCTAssertEqual(testObject.statusString, "Please complete required areas, and check that you have submitted a valid email address.")
        XCTAssertEqual(mockService.postCount, 0)
    }
    
    func testErrorStatusIsSetWhenFeedbackIsMissingEmail() async {
        let mockService = MockService()
        let testObject = FeedbackViewModel(mockService)
        testObject.feedback.name = "Some Name"
        testObject.feedback.comment = "some comment"
        testObject.feedback.rating = 5
        await testObject.submitButtonTap()
        XCTAssertEqual(testObject.statusString, "Please complete required areas, and check that you have submitted a valid email address.")
        XCTAssertEqual(mockService.postCount, 0)
    }
    
    func testErrorStatusIsSetWhenFeedbackEmailIsInvalid() async {
        let mockService = MockService()
        let testObject = FeedbackViewModel(mockService)
        testObject.feedback.name = "Some Name"
        testObject.feedback.comment = "some comment"
        testObject.feedback.rating = 5
        testObject.feedback.email = "valid@email"
        await testObject.submitButtonTap()
        XCTAssertEqual(testObject.statusString, "Please complete required areas, and check that you have submitted a valid email address.")
        XCTAssertEqual(mockService.postCount, 0)
    }
    
    func testErrorStatusIsSetWhenFeedbackIsMissingComment() async {
        let mockService = MockService()
        let testObject = FeedbackViewModel(mockService)
        testObject.feedback.name = "Some Name"
        testObject.feedback.rating = 5
        testObject.feedback.email = "valid@email.com"
        await testObject.submitButtonTap()
        XCTAssertEqual(testObject.statusString, "Please complete required areas, and check that you have submitted a valid email address.")
        XCTAssertEqual(mockService.postCount, 0)
    }
    
    func testPostIsCalledWhenFeedbackIsValid() async {
        let mockService = MockService()
        let testObject = FeedbackViewModel(mockService)
        testObject.feedback.name = "Some Name"
        testObject.feedback.comment = "some comment"
        testObject.feedback.rating = 5
        testObject.feedback.email = "valid@email.com"
        await testObject.submitButtonTap()
        XCTAssertEqual(mockService.postCount, 1)
    }

}

class MockService: Networking {
    var postCount = 0
    
    func post<T>(from path: String, body: T) async throws -> T where T : Decodable, T : Encodable {
            postCount = postCount + 1
        return body
    }
}
