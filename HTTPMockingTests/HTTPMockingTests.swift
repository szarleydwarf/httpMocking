//
//  HTTPMockingTests.swift
//  HTTPMockingTests
//
//  Created by The App Experts on 26/03/2023.
//

import XCTest
@testable import HTTPMocking

final class HTTPMockingTests: XCTestCase {

    override func tearDown() {
            HTTPClientProtocol.loadingHandler = nil
        }
        
        struct TestPayload: Codable, Equatable {
            let country: String
        }
        
        func testFetchingDataSuccessfully() {
            let expected = TestPayload(country: "Estonia")
            let request = URLRequest(url: URL(string: "https://www.example.com")!)
            let responseJSONData = try! JSONEncoder().encode(expected)
            HTTPClientProtocol.loadingHandler = { request in
                let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
                return (response, responseJSONData, nil)
            }
        
            let expectation = XCTestExpectation(description: "Loading")
            let configuration = URLSessionConfiguration.ephemeral
            configuration.protocolClasses = [HTTPClientProtocol.self]
            let client = HTTPClient(session: URLSession(configuration: configuration))
            client.fetch(request, requestDataType: TestPayload.self) { (result) in
                switch result {
                case .failure(let error):
                    XCTFail("Request was not successful: \(error.localizedDescription)")
                case .success(let payload):
                    XCTAssertEqual(payload, expected)
                }
                expectation.fulfill()
            }
            wait(for: [expectation], timeout: 1)
        }

}
