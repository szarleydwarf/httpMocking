//
//  HTTPClientFactory.swift
//  HTTPMocking
//
//  Created by Chomik, Radoslaw on 02/07/2023.
//

import Foundation

class HTTPClientFactory {
    static func create() -> HTTPClientProtocol {
        let env = ProcessInfo().environment["ENV"]
        if env == "TEST" {
            return MockHTTPClient()
        }
        
        return HTTPClient()
    }
}
