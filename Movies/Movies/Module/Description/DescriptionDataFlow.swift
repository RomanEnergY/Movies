//
//  DescriptionDataFlow.swift
//  Movies
//
//  Created by Roman Zverik on 16.02.2021.
//  Copyright © 2021 ZRS. All rights reserved.
//

import Foundation

enum Description {
	
	enum ViewState {
		case loading
		case unLoading
		case update(data: DescriptionMovieAPI)
	}
}
