//
//  HTTPClientProtocol.swift
//  HTTPMocking
//
//  Created by The App Experts on 12/04/2023.
//

import Foundation

final class HTTPClientProtocol: URLProtocol {
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    static var loadingHandler: ((URLRequest) -> (HTTPURLResponse, Data?, Error?))?
    
    override func startLoading() {
        guard let handler = HTTPClientProtocol.loadingHandler else {
//            XCTFail("Loading handler is not set.")
            return
        }
        let (response, data, error) = handler(request)
        if let data = data {
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            client?.urlProtocol(self, didLoad: data)
            client?.urlProtocolDidFinishLoading(self)
        }
        else {
            client?.urlProtocol(self, didFailWithError: error!)
        }
    }
    
    override func stopLoading() {}
}
