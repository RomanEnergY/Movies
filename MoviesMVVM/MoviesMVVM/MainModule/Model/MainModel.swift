//
//  MainDataModel.swift
//  MoviesMVVM
//
//  Created by 1234 on 16.09.2020.
//  Copyright © 2020 ZRS. All rights reserved.
//

import Foundation

//MARK: - MainMovieProtocol
protocol MainModelMovieProtocol {
    var id: Int { get }
    var title: String { get }
    var rating: Double { get }
    var releaseDate: Date? { get }
    var iconString: String? { get }
    var overview: String { get }
}

//MARK: - MainModelProtocol
protocol MainModelProtocol {
    var movies: [MainModelMovieProtocol] { get set }
}

//MARK: - MainModel: MainModelProtocol
class MainModel: MainModelProtocol {
    var movies: [MainModelMovieProtocol] = []
}
