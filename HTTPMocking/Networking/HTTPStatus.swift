//
//  HTTPStatus.swift
//  HTTPMocking
//
//  Created by Chomik, Radoslaw on 05/07/2023.
//

import Foundation

public struct HTTPStatus {
    var status: Int
    init(rawValue: Int) {
        self.status = rawValue
    }
    
    func getStatus() {
        // posible a switch returning string or enum with status
    }
}
