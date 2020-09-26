//
//  MovieApi.swift
//  MoviesMVVM
//
//  Created by 1234 on 15.09.2020.
//  Copyright © 2020 ZRS. All rights reserved.
//

import Foundation

enum MovieDataEndPoint: EndPointProtocol {
    //MARK: - public TimeWindows type
    public enum TimeWindows: String {
        case day
        case week
    }
    
    //MARK: - enum case
    case trending(timeWindows: TimeWindows, page: Int)
    case nowPlaying(page: Int)
    case popular(page: Int)
    case topRated(page: Int)
    case upcoming(page: Int)
    case movieId(id: Int)
    
    //MARK: - public var EndPointProtocol
    public var baseURL: String {
        return NetworkData.baseURL
    }
    
    public var path: String {
        switch self {
        case .trending(let timeWindows, _): return "trending/movie/\(timeWindows.rawValue)"
        case .nowPlaying(page: _): return "movie/now_playing"
        case .popular(page: _): return "movie/popular"
        case .topRated(page: _): return "movie/top_rated"
        case .upcoming(page: _): return "movie/upcoming"
        case .movieId(let id): return "movie/\(id)"
        }
    }
    
    public var httpMethod: HTTPMethod {
        return .get
    }
    
    public var task: HTTPTask {
        switch self {
        case .trending(_ , let page),
             .nowPlaying(let page),
             .popular(let page),
             .topRated(let page),
             .upcoming(let page): return getDefaultRequestParameters(page)
            
        case .movieId: return .requestParameters(bodyParameters: nil,
                                      urlParameters: [ "api_key": NetworkData.APIKey,
                                                       "language": NetworkData.language])
            
        }
    }
    
    public var headers: HTTPHeaders? {
        return nil
    }
    
    private func getDefaultRequestParameters(_ page: Int) -> HTTPTask{
        return .requestParameters(bodyParameters: nil,
                                  urlParameters: [ "page": page,
                                                   "api_key": NetworkData.APIKey,
                                                   "language": NetworkData.language])
    }
}
