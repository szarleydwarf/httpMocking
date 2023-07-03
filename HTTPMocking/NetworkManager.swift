//
//  NetworkManager.swift
//  HTTPMocking
//
//  Created by Chomik, Radoslaw on 03/07/2023.
//

import Foundation

enum NetworkResult: Equatable {
    static func == (lhs: NetworkResult, rhs: NetworkResult) -> Bool {
        return true
    }
    
    case success(Data)
    case failure(Error?)
}
class NetworkManager {
    private let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }

    func loadData(from url: URL,
                  completionHandler: @escaping (NetworkResult) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            // Create either a .success or .failure case of a result enum
            let result = data.map(NetworkResult.success) ?? .failure(error)
            completionHandler(result)
        }
        
        task.resume()
    }
}

// We create a partial mock by subclassing the original class
class URLSessionDataTaskMock: URLSessionDataTask {
    private let closure: () -> Void

    init(closure: @escaping () -> Void) {
        self.closure = closure
    }

    // We override the 'resume' method and simply call our closure
    // instead of actually resuming any task.
    override func resume() {
        closure()
    }
}

class URLSessionMock: URLSession {
    typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void

    // Properties that enable us to set exactly what data or error
    // we want our mocked URLSession to return for any request.
    var data: Data?
    var error: Error?

    override func dataTask(
        with url: URL,
        completionHandler: @escaping CompletionHandler
    ) -> URLSessionDataTask {
        let data = self.data
        let error = self.error

        return URLSessionDataTaskMock {
            completionHandler(data, nil, error)
        }
    }
}
