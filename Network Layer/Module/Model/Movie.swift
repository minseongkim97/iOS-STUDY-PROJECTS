//
//  Movie.swift
//  Network Layer
//
//  Created by MIN SEONG KIM on 2021/05/25.
//

import UIKit

struct MovieApiResponse {
    let numberOfResults: Int
    let numberOfPages: Int
    let movies: [Movie]
}

extension MovieApiResponse: Decodable {
    
    private enum MovieApiResponseCodingKeys: String, CodingKey {
        case numberOfResults = "total"
        case numberOfPages = "start"
        case movies = "items"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: MovieApiResponseCodingKeys.self)
        
        numberOfResults = try container.decode(Int.self, forKey: .numberOfResults)
        numberOfPages = try container.decode(Int.self, forKey: .numberOfPages)
        movies = try container.decode([Movie].self, forKey: .movies)
        
    }
}


struct Movie {
    let title: String
    let link: String
    let imageURL: String
    let subtitle: String
    let pubDate: String
    let director: String
    let actors: String
    let userRating: String
}

extension Movie: Decodable {
    
    enum MovieCodingKeys: String, CodingKey {
        case title
        case link
        case imageURL = "image"
        case subtitle
        case pubDate
        case director
        case actor
        case userRating
    }
    
    
    init(from decoder: Decoder) throws {
        let movieContainer = try decoder.container(keyedBy: MovieCodingKeys.self)
        
        title = try movieContainer.decode(String.self, forKey: .title)
        link = try movieContainer.decode(String.self, forKey: .link)
        imageURL = try movieContainer.decode(String.self, forKey: .imageURL)
        subtitle = try movieContainer.decode(String.self, forKey: .subtitle)
        pubDate = try movieContainer.decode(String.self, forKey: .pubDate)
        director = try movieContainer.decode(String.self, forKey: .director)
        actors = try movieContainer.decode(String.self, forKey: .actor)
        userRating = try movieContainer.decode(String.self, forKey: .userRating)

    }
}
