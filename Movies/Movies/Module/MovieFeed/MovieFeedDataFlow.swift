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
		enum Group {
			case initial(data: [String])
			case select(number: Int)
			case loading(number: Int)
			case unLoading(number: Int)
		}
		
		enum Collection {
			case loading
			case unLoading
			case updateImage(posterPath: String, data: Data?)
			case removeData
			case append(data: [MainModelMovieProtocol])
		}
	}
}
