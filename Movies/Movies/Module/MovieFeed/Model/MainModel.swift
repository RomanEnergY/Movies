//
//  MainDataModel.swift
//  Movies
//
//  Created by Roman Zverik on 16.09.2020.
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
	var iconString: String? { get }
	var overview: String { get }
}

//MARK: - MainModelProtocol
protocol MainModelProtocol {
	var groups: [Group] { get }
	var movies: [MainModelMovieProtocol] { get set }
}

//MARK: - MainModel: MainModelProtocol
class MainModel: MainModelProtocol {
	let groups: [Group] = [.trending, .nowPlaying, .popular, .topRated, .upcoming]
	var movies: [MainModelMovieProtocol] = []
}
