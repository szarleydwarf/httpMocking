//
//  HTTPLoading.swift
//  HTTPMocking
//
//  Created by Chomik, Radoslaw on 06/07/2023.
//

import Foundation

public protocol HTTPLoading {
    func load(request: HTTPRequest, completion: @escaping (HTTPResult) -> Void)
}
