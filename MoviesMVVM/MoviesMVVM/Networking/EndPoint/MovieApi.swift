//
//  MovieApi.swift
//  MoviesMVVM
//
//  Created by 1234 on 15.09.2020.
//  Copyright © 2020 ZRS. All rights reserved.
//

import Foundation

public enum TimeWindows: String {
    case day
    case week
}

public enum MovieApi {
    case trending(timeWindows: TimeWindows, page: Int)
    case movieId(id: Int)
    case movieNowPlaying(page: Int)
}

extension MovieApi: EndPointType {
    var baseURL: String {
        return "https://api.themoviedb.org/3/"
    }
    
    var path: String {
        switch self {
        case .trending(let timeWindows, _): return "trending/movie/\(timeWindows.rawValue)"
        case .movieId(let id): return "movie/\(id)"
        case .movieNowPlaying: return "movie/now_playing"
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask {
        switch self {
        case .trending(_ , let page):
            return .requestParameters(bodyParameters: nil,
                                      urlParameters: [
                                        "page": page,
                                        "api_key": NetworkManager.movieAPIKey,
                                        "language": NetworkManager.language])
            
        case .movieId:
            return .requestParameters(bodyParameters: nil,
                                      urlParameters: [
                                        "api_key": NetworkManager.movieAPIKey,
                                        "language": NetworkManager.language])
            
        case .movieNowPlaying(let page):
            return .requestParameters(bodyParameters: nil,
                                      urlParameters: [
                                        "page": page,
                                        "api_key": NetworkManager.movieAPIKey,
                                        "language": NetworkManager.language])
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}
