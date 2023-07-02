//
//  HTTPClient.swift
//  HTTPMocking
//
//  Created by The App Experts on 12/04/2023.
//

import Foundation

class HTTPClient: HTTPClientProtocol {

    func authenticate(_ username: String, _ password: String, completion: @escaping (UserObj?) -> Void) {
        guard let url = URL(string:  "https://succinct-fourth-scent.glitch.me/hithere") else {
            return
        }
        
        let params  = ["username": username, "password": password]
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = try? JSONEncoder().encode(params)
        
        URLSession.shared.dataTask(with: request) { data, resp, erro in
            guard let data = data,  erro == nil else {
                return
            }
            
            if let loginInfo = try? JSONDecoder().decode(UserObj.self, from: data) {
                completion(loginInfo)
            }
            
        }.resume()
    }
}
