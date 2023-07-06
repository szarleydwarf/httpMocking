//
//  URLSession+ext.swift
//  HTTPMocking
//
//  Created by Chomik, Radoslaw on 06/07/2023.
//

import Foundation

extension URLSession: HTTPLoading {
    public func load(request: HTTPRequest, completion: @escaping (HTTPResult) -> Void) {
        guard let url = request.url else {
            // we couldn't construct a proper URL out of the request's URLComponents
            completion(.failure(HTTPError(code: .invalidRequest, request: request, response: nil, underlyingError: .none)))
            return
        }
        
        // construct the URLRequest
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        
        // copy over any custom HTTP headers
        for (header, value) in request.headers {
            urlRequest.addValue(value, forHTTPHeaderField: header)
        }
        
        if request.body?.isEmpty == false,
           let additionalHeaders = request.body?.additionalHeaders {
            // if our body defines additional headers, add them
            for (header, value) in additionalHeaders {
                urlRequest.addValue(value, forHTTPHeaderField: header)
            }
            
            // attempt to retrieve the body data
            do {
                urlRequest.httpBody = try request.body?.encode()
            } catch {
                // something went wrong creating the body; stop and report back
                completion(.failure(HTTPError(code: .invalidResponse, request: request, response: nil, underlyingError: .none)))
                return
            }
        }
        
        let dataTask = self.dataTask(with: urlRequest) { (data, response, error) in
            // construct a Result<HTTPResponse, HTTPError> out of the triplet of data, url response, and url error
            let result = HTTPResult
            }
            completion(result)
        }
        
        // off we go!
        dataTask.resume()
    }
}
