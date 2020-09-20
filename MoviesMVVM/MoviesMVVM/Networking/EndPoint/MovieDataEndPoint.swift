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
    case movieId(id: Int)
    case movieNowPlaying(page: Int)
    
    //MARK: - public var EndPointProtocol
    public var baseURL: String {
        return NetworkData.baseURL
    }
    
    public var path: String {
        switch self {
        case .trending(let timeWindows, _): return "trending/movie/\(timeWindows.rawValue)"
        case .movieId(let id): return "movie/\(id)"
        case .movieNowPlaying: return "movie/now_playing"
        }
    }
    
    public var httpMethod: HTTPMethod {
        return .get
    }
    
    public var task: HTTPTask {
        switch self {
        case .trending(_ , let page):
            return .requestParameters(bodyParameters: nil,
                                      urlParameters: [ "page": page,
                                                       "api_key": NetworkData.APIKey,
                                                       "language": NetworkData.language])
            
        case .movieId:
            return .requestParameters(bodyParameters: nil,
                                      urlParameters: [ "api_key": NetworkData.APIKey,
                                                       "language": NetworkData.language])
            
        case .movieNowPlaying(let page):
            return .requestParameters(bodyParameters: nil,
                                      urlParameters: [ "page": page,
                                                       "api_key": NetworkData.APIKey,
                                                       "language": NetworkData.language])
        }
    }
    
    public var headers: HTTPHeaders? {
        return nil
    }
}
