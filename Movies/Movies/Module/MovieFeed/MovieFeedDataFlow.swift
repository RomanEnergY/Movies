//
//  MovieFeedDataFlow.swift
//  Movies
//
//  Created by Roman Zverik on 24.02.2021.
//  Copyright © 2021 ZRS. All rights reserved.
//

import Foundation

enum MovieFeed {
	
	enum ViewState {
		case initialSelect(data: [String])
		case selectGroup(number: Int)
		case loading
	}
}
