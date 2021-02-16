//
//  DescriptionModel.swift
//  Movies
//
//  Created by Roman Zverik on 16.09.2020.
//  Copyright © 2020 ZRS. All rights reserved.
//

import Foundation

//MARK: - DescriptionMovieProtocol
protocol DescriptionModelMovieProtocol {
	var title: String { get }
	var tagline: String { get }
	var overview: String { get }
}

//MARK: - DescriptionModelProtocol
protocol DescriptionModelProtocol {
	var descriptionMovie: DescriptionModelMovieProtocol { get set }
}

//MARK: - DescriptionModel: DescriptionModelProtocol
struct DescriptionModel: DescriptionModelProtocol {
	var descriptionMovie: DescriptionModelMovieProtocol
}
