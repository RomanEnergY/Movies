//
//  URLParameterEncoder.swift
//  Movies
//
//  Created by Roman Zverik on 15.09.2020.
//  Copyright © 2020 ZRS. All rights reserved.
//

import Foundation

public struct URLParameterEncoder: ParameterEncoder {
	public static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
		guard let url = urlRequest.url else { throw NetworkError.missingURL }
		
		if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false), !parameters.isEmpty {
			urlComponents.queryItems = [URLQueryItem]()
			
			parameters.forEach({
				let queryItem = URLQueryItem(name: $0.key, value: "\($0.value)".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed))
				urlComponents.queryItems?.append(queryItem)
			})
			
			urlRequest.url = urlComponents.url
		}
		
		if urlRequest.value(forHTTPHeaderField: "Contrnt-Type") == nil {
			urlRequest.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
		}
	}
}
