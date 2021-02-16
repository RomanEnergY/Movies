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
		let dateFormatter = DateFormatter()
		dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
		dateFormatter.dateFormat = "yyyy-MM-dd"
		let date = dateFormatter.date(from: releaseDateFromString)
		
		return date
	}
	
	var rating: Double { voteAverage }
	var iconString: String? { posterPath }
}
