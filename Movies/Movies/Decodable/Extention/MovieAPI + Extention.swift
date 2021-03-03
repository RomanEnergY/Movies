//
//  MovieAPI + Extention.swift
//  Movies
//
//  Created by Roman Zverik on 17.09.2020.
//  Copyright © 2020 ZRS. All rights reserved.
//

import Foundation

extension MovieAPI: MainModelMovieProtocol {
	var releaseDate: Date? {
		releaseDateFromString.formatter(dateFormat: "yyyy-MM-dd")
	}
	
	var rating: Double { voteAverage }
	var iconString: String? { posterPath }
}
