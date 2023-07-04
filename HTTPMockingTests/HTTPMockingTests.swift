//
//  HTTPMockingTests.swift
//  HTTPMockingTests
//
//  Created by The App Experts on 26/03/2023.
// "https://succinct-fourth-scent.glitch.me/userLoginTest"

import XCTest
@testable import HTTPMocking

final class HTTPMockingTests: XCTestCase {
    
    func testSuccessfulResponse() {
        // Setup our objects
        let session = URLSessionMock()
        let manager = NetworkManager(session: session)
        
        // Create data and tell the session to always return it
        let data = Data(_: [0, 1, 0, 1])
        session.data = data
        
        // Create a URL (using the file path API to avoid optionals)
        let url = URL(fileURLWithPath: "/data.json")
        
        // Perform the request and verify the result
        var result: NetworkResult?
        manager.loadData(from: url) { result = $0 }
        XCTAssertEqual(result, .success(data))
    }
}
