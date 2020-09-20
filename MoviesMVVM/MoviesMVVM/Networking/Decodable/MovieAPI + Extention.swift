//
//  MovieAPI + Extention.swift
//  MoviesMVVM
//
//  Created by 1234 on 17.09.2020.
//  Copyright © 2020 ZRS. All rights reserved.
//

import Foundation

extension MovieAPI: MainMovieProtocol {
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
