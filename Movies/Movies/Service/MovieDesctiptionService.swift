//
//  MovieDesctiptionServiceProtocol.swift
//  Movies
//
//  Created by Roman Zverik on 15.09.2020.
//  Copyright © 2020 ZRS. All rights reserved.
//

import Foundation

//MARK: - MovieDesctiptionServiceProtocol
protocol MovieDesctiptionServiceProtocol {
	func getMovie(id: Int, completion: @escaping (Result<DescriptionMovieAPI?, Error>) -> ())
}

//MARK: - MovieDesctiptionService: MovieDesctiptionServiceProtocol
final class  MovieDesctiptionService: MovieDesctiptionServiceProtocol {
	
	//MARK: - private let
	private let networkService = NetworkService<MovieDataEndPoint>()
	
	//MARK: - public func MovieDesctiptionServiceProtocol
	public func getMovie(id: Int, completion: @escaping (Result<DescriptionMovieAPI?, Error>) -> ()) {
		networkService.request(endPoint: .movieId(id: id)) { (data, response, error) in
			if let error = error {
				completion(.failure(error))
				return
			}
			
			do {
				let dataDecode = try JSONDecoder().decode(DescriptionMovieAPI.self, from: data!)
				DispatchQueue.main.async {
					completion(.success(dataDecode))
				}
			} catch {
				completion(.failure(error))
			}
		}
	}
}
