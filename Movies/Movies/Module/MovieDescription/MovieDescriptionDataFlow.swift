//
//  MovieDescriptionDataFlow.swift
//  Movies
//
//  Created by Roman Zverik on 16.02.2021.
//  Copyright © 2021 ZRS. All rights reserved.
//

import Foundation

enum MovieDescription {
	
	enum ViewState {
		case loading
		case unLoading
		case update(model: DescriptionMovieModelProtocol)
		case updateImage(data: Data?)
		case loadingServiceError(text: String)
	}
}
