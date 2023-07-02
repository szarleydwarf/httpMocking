//
//  HTTPClientProtocol.swift
//  HTTPMocking
//
//  Created by The App Experts on 12/04/2023.
//

import Foundation

protocol HTTPClientProtocol {
    func auth(_ username: String, _ password: String, completion: @escaping (LoginInfo) -> Void)
}
