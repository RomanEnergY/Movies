//
//  MockMainMovie.swift
//  MoviesMVVMTests
//
//  Created by 1234 on 22.09.2020.
//  Copyright © 2020 ZRS. All rights reserved.
//

import Foundation
@testable import MoviesMVVM

struct MockMainMovie: MainModelMovieProtocol {
    var id: Int
    var title: String
    var rating: Double
    var releaseDate: Date?
    var iconString: String?
    var overview: String
}
