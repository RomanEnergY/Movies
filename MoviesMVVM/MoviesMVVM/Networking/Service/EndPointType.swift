//
//  EndPointTypeProtocol.swift
//  MoviesMVVM
//
//  Created by 1234 on 15.09.2020.
//  Copyright © 2020 ZRS. All rights reserved.
//

import Foundation

protocol EndPointType {
    var baseURL: String { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
    var headers: HTTPHeaders? { get }
}
