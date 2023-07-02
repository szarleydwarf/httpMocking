//
//  HTTPClient.swift
//  HTTPMocking
//
//  Created by The App Experts on 12/04/2023.
//

import Foundation

class HTTPClient {
    
    func auth(_ username: String, _ password: String, completion: @escaping (LoginInfo) -> Void) {
        guard let url = URL(string:  "some url") else {
            return
        }
        
        let params  = ["username": username, "password": password]
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.httpBody = try? JSONEncoder().encode(params)
        
        URLSession.shared.dataTask(with: request) { data, resp, erro in
            guard let data = data,  erro == nil else {
                return
            }
            
            let loginInfo = try? JSONDecoder().decode(LoginInfo.self, from: data)
            completion(loginInfo)
            
        }.resume()
    }
}
