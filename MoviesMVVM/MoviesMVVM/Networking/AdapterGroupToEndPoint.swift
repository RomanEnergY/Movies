//
//  AdapterGroupToEndPoint.swift
//  MoviesMVVM
//
//  Created by 1234 on 26.09.2020.
//  Copyright © 2020 ZRS. All rights reserved.
//

import Foundation

class AdapterGroupToEndPoint {
    public static func get(_ group: Group, page: Int) -> MovieDataEndPoint {
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
