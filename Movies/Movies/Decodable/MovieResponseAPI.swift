//
//  MovieApiResponse.swift
//  Movies
//
//  Created by Roman Zverik on 15.09.2020.
//  Copyright © 2020 ZRS. All rights reserved.
//

import Foundation

struct MovieResponseAPI {
	let currentPage: Int
	let totalPage: Int
	let movies: [MovieAPI]
}

extension MovieResponseAPI: Decodable {
	
	private enum MovieApiResponseCodingKeys: String, CodingKey {
		case currentPage = "page"
		case totalPage = "total_pages"
		case movies = "results"
	}
	
	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: MovieApiResponseCodingKeys.self)
		currentPage = try container.decode(Int.self, forKey: .currentPage)
		totalPage = try container.decode(Int.self, forKey: .totalPage)
		movies = try container.decode([MovieAPI].self, forKey: .movies)
	}
}
