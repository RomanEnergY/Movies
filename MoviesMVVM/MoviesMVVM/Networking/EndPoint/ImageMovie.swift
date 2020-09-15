//
//  ImageMovie.swift
//  MoviesMVVM
//
//  Created by 1234 on 15.09.2020.
//  Copyright © 2020 ZRS. All rights reserved.
//

import Foundation

enum ImageMovie {
    case imageTmBD(whith: Int, posterPath: String)
}

extension ImageMovie: EndPointType {
    var baseURL: String {
        switch self {
        case .imageTmBD(let whith, _): return "https://image.tmdb.org/t/p/w\(whith)"
        }
    }
    
    var path: String {
        switch self {
        case .imageTmBD(_, let posterPath): return "\(posterPath)"
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask {
        switch self {
        case .imageTmBD:
            return .request
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}
