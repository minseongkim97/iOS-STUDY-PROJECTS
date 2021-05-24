//
//  EndPointType.swift
//  Network Layer
//
//  Created by MIN SEONG KIM on 2021/05/25.
//

import Foundation

protocol EndPointType {
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
    var headers: HTTPHeaders? { get }
}

