//
//  User.swift
//  HTTPMocking
//
//  Created by Chomik, Radoslaw on 02/07/2023.
//

import Foundation

struct UserObj: Decodable {
    let message: String
    let loginInfo: LoginInfo
    let user: User
}

struct LoginInfo: Decodable {
    var successInfo: String
    var errorInfo: String
}

struct User: Decodable {
    let name: String
    let password: String
}
