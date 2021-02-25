//
//  MovieDataService.swift
//  Movies
//
//  Created by Roman Zverik on 15.09.2020.
//  Copyright © 2020 ZRS. All rights reserved.
//

import Foundation

//MARK: - MovieDataServiceProtocol
protocol MovieDataServiceProtocol {
	func getDataNewGroup(group: Group, completion: @escaping ([MainModelMovieProtocol]?) -> ()) -> Void
	func nextPage(completion: @escaping ([MainModelMovieProtocol]?) -> ()) -> Void
}

//MARK: - class MovieDataService: MovieDataServiceProtocol
final class MovieDataService: MovieDataServiceProtocol {
	//MARK: - private var
	private let timeWindows: MovieDataEndPoint.TimeWindows = .week
	private let networkService = NetworkService<MovieDataEndPoint>()
	private var currentGroup: Group?
	private var currentPage: Int = 1
	
	//MARK: - public func MovieDataServiceProtocol
	public func getDataNewGroup(group: Group, completion: @escaping ([MainModelMovieProtocol]?) -> ()) -> Void {
		currentPage = 1
		currentGroup = group
		getDataGroup { completion($0) }
	}
	
	public func nextPage(completion: @escaping ([MainModelMovieProtocol]?) -> ()) {
		currentPage += 1
		getDataGroup { completion($0) }
	}
	
	//MARK: - private func
	private func getDataGroup(completion: @escaping ([MainModelMovieProtocol]?) -> ()) {
		guard let group = currentGroup else { return }
		let endPoint = GroupToEndPoint.adapter(group, page: currentPage)
		
		networkService.request(endPoint: endPoint) { (data, response, error) in
			if let error = error {
				print("Error networkService.request:", error.localizedDescription)
				completion(nil)
				return
			}
			
			guard let data = data else {
				print("Error data: nil")
				completion(nil)
				
				return
			}
			
			do {
				let movieApiResponse = try JSONDecoder().decode(MovieResponseAPI.self, from: data)
				completion(movieApiResponse.movies)
				
			} catch {
				print("Error JSONDecoder().decode:", error.localizedDescription)
				completion(nil)
			}
		}
	}
}
