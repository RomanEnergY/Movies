//
//  AdapterGroupToEndPoint.swift
//  Movies
//
//  Created by Roman Zverik on 26.09.2020.
//  Copyright © 2020 ZRS. All rights reserved.
//

import Foundation

class GroupToEndPoint {
	public static func adapter(_ group: Group, page: Int) -> MovieDataEndPoint {
		switch group {
			case .trending:
				return MovieDataEndPoint.trending(timeWindows: .day, page: page)
				
			case .nowPlaying:
				return MovieDataEndPoint.nowPlaying(page: page)
				
			case .popular:
				return MovieDataEndPoint.popular(page: page)
				
			case .topRated:
				return MovieDataEndPoint.topRated(page: page)
				
			case .upcoming:
				return MovieDataEndPoint.upcoming(page: page)
				
		}
	}
}
