//
//  HTTPRequest.swift
//  HTTPMocking
//
//  Created by Chomik, Radoslaw on 05/07/2023.
//

import Foundation

public struct HTTPRequest {
    private var urlComponents = URLComponents()
    public var method: HTTPMethod = .get
    public var headers: [String: String] = [:]
    public var body: HTTPBody?

    public init() {
        urlComponents.scheme = "https"
    }
}

extension HTTPRequest {

    public var scheme: String { urlComponents.scheme ?? "https" }
    
    public var host: String? {
        get { urlComponents.host }
        set { urlComponents.host = newValue }
    }
    
    public var path: String {
        get { urlComponents.path }
        set { urlComponents.path = newValue }
    }

}

