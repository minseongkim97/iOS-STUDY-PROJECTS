//
//  MovieEndPoint.swift
//  Network Layer
//
//  Created by MIN SEONG KIM on 2021/05/25.
//

import Foundation

enum NetworkEnvironment {
    case search
}

public enum MovieApi {
    case movie(word:String)
}

extension MovieApi: EndPointType {
    
    var environmentBaseURL : String {
        switch NetworkManager.environment {
        case .search: return "https://openapi.naver.com/v1/search/"
        }
    }
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String {
        switch self {
        case .movie(_): return "movie.json"
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask {
        switch self {
        case .movie(let word):
//            return .requestParameters(bodyParameters: nil,
//                                      bodyEncoding: .urlEncoding,
//                                      urlParameters: ["query":word])
            return .requestParametersAndHeaders(bodyParameters: nil,
                                                bodyEncoding: .urlEncoding,
                                                urlParameters: ["query":word,
                                                                "display":100],
                                                additionHeaders: self.headers)
        }
    }
    
    var headers: HTTPHeaders? {
        return ["X-Naver-Client-Id":NetworkManager.clientID]
    }
}
