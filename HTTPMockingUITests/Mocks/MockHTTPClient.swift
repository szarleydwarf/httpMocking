//
//  MockHTTPClient.swift
//  HTTPMockingUITests
//
//  Created by Chomik, Radoslaw on 02/07/2023.
//

import Foundation
@testable import HTTPMocking

class MockHTTPClient: HTTPClientProtocol {
    func authenticate(_ username: String, _ password: String, completion: @escaping (UserObj?) -> Void) {
        guard let url = Bundle(for: MockHTTPClient.self).url(forResource: "success-response", withExtension: "json"),
              let data = try? Data(contentsOf: url) else {return completion(nil)}
        
        guard let user = try? JSONDecoder().decode(UserObj.self, from: data) else {return}
        completion(user)
    }
}
