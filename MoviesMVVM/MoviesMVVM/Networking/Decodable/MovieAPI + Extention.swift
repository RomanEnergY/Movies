//
//  MovieAPI + Extention.swift
//  MoviesMVVM
//
//  Created by 1234 on 17.09.2020.
//  Copyright © 2020 ZRS. All rights reserved.
//

import Foundation

extension MovieAPI: MainMovieProtocol {
    var rating: Double { voteAverage }
    var iconString: String? { posterPath }
}
