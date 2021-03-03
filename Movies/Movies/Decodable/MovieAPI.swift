//
//  MovieModel.swift
//  Movies
//
//  Created by Roman Zverik on 15.09.2020.
//  Copyright © 2020 ZRS. All rights reserved.
//

import Foundation

//MARK: - MainMovieProtocol
protocol MainModelMovieProtocol {
	/// Primery Key Movie
	var id: Int { get }
	var title: String { get }
	var rating: Double { get }
	var releaseDate: Date? { get }
	var overview: String { get }
	var posterPath: String? { get }
}

struct MovieAPI: MainModelMovieProtocol {
	let id: Int
	let video: Bool
	let voteCount: Int
	let rating: Double
	let title: String
	let releaseDateFromString: String
	let originalLanguage: String
	let originalTitle: String
	let genreIds: [Int]
	let backdropPath: String?
	let adult: Bool
	let overview: String
	let posterPath: String?
	var releaseDate: Date? {
		releaseDateFromString.formatter(dateFormat: "yyyy-MM-dd")
	}
}

extension MovieAPI: Decodable {
	
	enum MovieCodingKeys: String, CodingKey {
		case id
		case video
		case voteCount = "vote_count"
		case rating = "vote_average"
		case title
		case releaseDateFromString = "release_date"
		case originalLanguage = "original_language"
		case originalTitle = "original_title"
		case genreIds = "genre_ids"
		case backdropPath = "backdrop_path"
		case adult
		case overview
		case posterPath = "poster_path"
	}
	
	init(from decoder: Decoder) throws {
		let movieContainer = try decoder.container(keyedBy: MovieCodingKeys.self)
		id = try movieContainer.decode(Int.self, forKey: .id)
		video = try movieContainer.decode(Bool.self, forKey: .video)
		voteCount = try movieContainer.decode(Int.self, forKey: .voteCount)
		rating = try movieContainer.decode(Double.self, forKey: .rating)
		title = try movieContainer.decode(String.self, forKey: .title)
		releaseDateFromString = try movieContainer.decode(String.self, forKey: .releaseDateFromString)
		originalLanguage = try movieContainer.decode(String.self, forKey: .originalLanguage)
		originalTitle = try movieContainer.decode(String.self, forKey: .originalTitle)
		genreIds = try movieContainer.decode([Int].self, forKey: .genreIds)
		backdropPath = try movieContainer.decode(String?.self, forKey: .backdropPath)
		adult = try movieContainer.decode(Bool.self, forKey: .adult)
		overview = try movieContainer.decode(String.self, forKey: .overview)
		posterPath = try movieContainer.decode(String?.self, forKey: .posterPath)
	}
}
