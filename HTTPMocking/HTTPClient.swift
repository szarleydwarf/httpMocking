//
//  HTTPClient.swift
//  HTTPMocking
//
//  Created by The App Experts on 12/04/2023.
//

import Foundation

enum FetchError: Error {
    case response(Int)
    case invalidData(Error)
    case connection(Error)
    case unknown
}

class HTTPClient {
    private let session: URLSession
    
    
    init(session: URLSession) {
        self.session = session
        guard let url = URL(string:  "https://succinct-fourth-scent.glitch.me/userLoginTest") else {
            return
        }
    }
    
    func fetch<T: Decodable>(_ request: URLRequest, requestDataType: T.Type, completionHandler: @escaping (Result<T, FetchError>) -> Void) {
        let dataTask = session.dataTask(with: request) { (data, urlResponse, error) in
            if let error = error {
                DispatchQueue.main.async {
                    completionHandler(.failure(.connection(error)))
                }
                return
            }
            guard let urlResponse = urlResponse as? HTTPURLResponse else {
                DispatchQueue.main.async {
                    completionHandler(.failure(.unknown))
                }
                return
            }
            switch urlResponse.statusCode {
            case 200..<300:
                do {
                    let payload = try JSONDecoder().decode(requestDataType, from: data ?? Data())
                    DispatchQueue.main.async {
                        completionHandler(.success(payload))
                    }
                }
                catch let jsonError {
                    DispatchQueue.main.async {
                        completionHandler(.failure(.invalidData(jsonError)))
                    }
                }
            default:
                DispatchQueue.main.async {
                    completionHandler(.failure(.response(urlResponse.statusCode)))
                }
            }
        }
        dataTask.resume()
    }
}
