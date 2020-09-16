//
//  DescriptionModel.swift
//  MoviesMVVM
//
//  Created by 1234 on 16.09.2020.
//  Copyright © 2020 ZRS. All rights reserved.
//

import Foundation

//MARK: - DescriptionMovieProtocol
protocol DescriptionMovieProtocol {
    var title: String { get }
    var tagline: String { get }
    var overview: String { get }
}

//MARK: - DescriptionModelProtocol
protocol DescriptionModelProtocol {
    var descriptionMovie: DescriptionMovieProtocol { get set }
}

//MARK: - DescriptionModel: DescriptionModelProtocol
struct DescriptionModel: DescriptionModelProtocol {
    var descriptionMovie: DescriptionMovieProtocol
}
