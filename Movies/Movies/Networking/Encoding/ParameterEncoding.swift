//
//  ParameterEncoding.swift
//  Movies
//
//  Created by Roman Zverik on 15.09.2020.
//  Copyright © 2020 ZRS. All rights reserved.
//

import Foundation

public typealias Parameters = [String: Any]

public protocol ParameterEncoder {
	static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws
}

public enum NetworkError: String, Error {
	case parametersNil = "Parameters were nil."
	case encodingFailed = "Parameters encoding failed."
	case missingURL = "URL is nil."
}
