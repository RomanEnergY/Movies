//
//  DescriptionMovieModel.swift
//  MoviesMVVM
//
//  Created by 1234 on 15.09.2020.
//  Copyright © 2020 ZRS. All rights reserved.
//

import Foundation

struct DescriptionMovie {
    let id: Int
    let title: String
    let tagline: String
    let posterPath: String
    let budget: Int
    let overview: String
    let productionCountries: [ProductionCountrie]
    let genres: [Genre]
}

extension DescriptionMovie: Decodable {
    
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
        
        productionCountries = try container.decode([ProductionCountrie].self, forKey: .productionCountries)
        genres = try container.decode([Genre].self, forKey: .genres)
    }
}

struct Genre {
    let name: String
}

extension Genre: Decodable {
    
    enum GenreCodingKeys: String, CodingKey {
        case name
    }
    
    init(from decoder: Decoder) throws {
        let genreContainer = try decoder.container(keyedBy: GenreCodingKeys.self)
        
        name = try genreContainer.decode(String.self, forKey: .name)
    }
}

struct ProductionCountrie {
    let name: String
}

extension ProductionCountrie: Decodable {
    
    enum ProductionCountrieCodingKeys: String, CodingKey {
        case name
    }
    
    init(from decoder: Decoder) throws {
        let genreContainer = try decoder.container(keyedBy: ProductionCountrieCodingKeys.self)
        
        name = try genreContainer.decode(String.self, forKey: .name)
    }
}
