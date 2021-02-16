//
//  ImageMovie.swift
//  Movies
//
//  Created by Roman Zverik on 15.09.2020.
//  Copyright © 2020 ZRS. All rights reserved.
//

import Foundation

enum MovieImageEndPoint: EndPointProtocol {
	//MARK: - enum case
	case image(whith: Int, posterPath: String)
	
	//MARK: - public var EndPointProtocol
	public var baseURL: String {
		switch self {
			case .image(let whith, _): return "https://image.tmdb.org/t/p/w\(whith)"
		}
	}
	
	public var path: String {
		switch self {
			case .image(_, let posterPath): return "\(posterPath)"
		}
	}
	
	public var httpMethod: HTTPMethod { .get }
	
	public var task: HTTPTask {
		switch self {
			case .image:
				return .requesNotParameters
		}
	}
	
	public var headers: HTTPHeaders? { nil }
}
