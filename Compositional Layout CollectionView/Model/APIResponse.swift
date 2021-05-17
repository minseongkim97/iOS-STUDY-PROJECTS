//
//  APIResponse.swift
//  Compositional Layout CollectionView
//
//  Created by MIN SEONG KIM on 2021/05/18.
//

import Foundation

struct APIResponse: Codable {
    let total: Int
    let total_pages: Int
    let results: [Result]
}

struct Result: Codable {
    let id: String
    let urls: URLS
}

struct URLS: Codable {
    let regular: String
}
