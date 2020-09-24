//
//  MovieModel.swift
//  MoviesMVVM
//
//  Created by 1234 on 15.09.2020.
//  Copyright © 2020 ZRS. All rights reserved.
//

import Foundation

struct MovieAPI {
    let id: Int
    let video: Bool
    let voteCount: Int
    let voteAverage: Double
    let title: String
    let releaseDateFromString: String
    let originalLanguage: String
    let originalTitle: String
    let genreIds: [Int]
    let backdropPath: String?
    let adult: Bool
    let overview: String
    let posterPath: String?
    let popularity: Double
    let mediaType: String
}

extension MovieAPI: Decodable {
    
    enum MovieCodingKeys: String, CodingKey {
        case id
        case video
        case voteCount = "vote_count"
        case voteAverage = "vote_average"
        case title
        case releaseDateFromString = "release_date"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case genreIds = "genre_ids"
        case backdropPath = "backdrop_path"
        case adult
        case overview
        case posterPath = "poster_path"
        case popularity
        case mediaType = "media_type"
    }
    
    init(from decoder: Decoder) throws {
        let movieContainer = try decoder.container(keyedBy: MovieCodingKeys.self)
        id = try movieContainer.decode(Int.self, forKey: .id)
        video = try movieContainer.decode(Bool.self, forKey: .video)
        voteCount = try movieContainer.decode(Int.self, forKey: .voteCount)
        voteAverage = try movieContainer.decode(Double.self, forKey: .voteAverage)
        title = try movieContainer.decode(String.self, forKey: .title)
        releaseDateFromString = try movieContainer.decode(String.self, forKey: .releaseDateFromString)
        originalLanguage = try movieContainer.decode(String.self, forKey: .originalLanguage)
        originalTitle = try movieContainer.decode(String.self, forKey: .originalTitle)
        genreIds = try movieContainer.decode([Int].self, forKey: .genreIds)
        backdropPath = try movieContainer.decode(String.self, forKey: .backdropPath)
        adult = try movieContainer.decode(Bool.self, forKey: .adult)
        overview = try movieContainer.decode(String.self, forKey: .overview)
        posterPath = try movieContainer.decode(String.self, forKey: .posterPath)
        popularity = try movieContainer.decode(Double.self, forKey: .popularity)
        mediaType = try movieContainer.decode(String.self, forKey: .mediaType)
    }
}

