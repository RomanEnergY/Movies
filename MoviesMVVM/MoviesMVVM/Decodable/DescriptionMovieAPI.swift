//
//  DescriptionMovieModel.swift
//  MoviesMVVM
//
//  Created by 1234 on 15.09.2020.
//  Copyright © 2020 ZRS. All rights reserved.
//

import Foundation

// Сущность модели данных описания фмльма
struct DescriptionMovieAPI {
    let id: Int
    let title: String
    let tagline: String
    let posterPath: String
    let budget: Int
    let overview: String
    let productionCountries: [ProductionCountrieAPI]
    let genres: [GenreAPI]
}

extension DescriptionMovieAPI: Decodable {
    
    private enum DescriptionMovieCodingKeys: String, CodingKey {
        case id
        case title
        case tagline
        case posterPath = "poster_path"
        case budget
        case overview
        case productionCountries = "production_countries"
        case genres
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DescriptionMovieCodingKeys.self)
        
        id = try container.decode(Int.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        tagline = try container.decode(String.self, forKey: .tagline)
        posterPath = try container.decode(String.self, forKey: .posterPath)
        budget = try container.decode(Int.self, forKey: .budget)
        overview = try container.decode(String.self, forKey: .overview)
        
        productionCountries = try container.decode([ProductionCountrieAPI].self, forKey: .productionCountries)
        genres = try container.decode([GenreAPI].self, forKey: .genres)
    }
}
