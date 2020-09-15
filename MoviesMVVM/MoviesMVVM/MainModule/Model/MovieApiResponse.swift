//
//  MovieApiResponse.swift
//  MoviesMVVM
//
//  Created by 1234 on 15.09.2020.
//  Copyright © 2020 ZRS. All rights reserved.
//

import Foundation

struct MovieApiResponse {
    let currentPage: Int
    let totalPage: Int
    let movies: [Movie]
}

extension MovieApiResponse: Decodable {
    
    private enum MovieApiResponseCodingKeys: String, CodingKey {
        case currentPage = "page"
        case totalPage = "total_pages"
        case movies = "results"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: MovieApiResponseCodingKeys.self)
        
        currentPage = try container.decode(Int.self, forKey: .currentPage)
        totalPage = try container.decode(Int.self, forKey: .totalPage)
        movies = try container.decode([Movie].self, forKey: .movies)
    }
}
