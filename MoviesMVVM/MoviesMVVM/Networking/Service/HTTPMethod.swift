//
//  HTTPMethod.swift
//  MoviesMVVM
//
//  Created by 1234 on 15.09.2020.
//  Copyright © 2020 ZRS. All rights reserved.
//

import Foundation

/// Enum использоваться для установки HTTP-метода запроса.
///
///     case get = "GET"
///     case post = "POST"
///     case put = "PUT"
///     case delete = "DELETE"

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}
