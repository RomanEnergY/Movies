//
//  MovieImageServiceProtocol.swift
//  Movies
//
//  Created by Roman Zverik on 15.09.2020.
//  Copyright © 2020 ZRS. All rights reserved.
//

import Foundation

//MARK: - MovieImageServiceProtocol
protocol MovieImageServiceProtocol {
	func getIcon(posterPath: String, completion: @escaping (Result<Data?, Error>) -> Void)
}

//MARK: - MovieImageServiceConst
enum MovieImageServiceConst {
	static let whith = 300
}

//MARK: - class MovieImageService: MovieImageServiceProtocol
final class MovieImageService: MovieImageServiceProtocol {
	//MARK: - private let
	private var imageCache = NSCache<NSString, NSData>() // кэш (forKey: posterPath) -> data
	private let routerImageMovie = NetworkService<MovieImageEndPoint>()
	
	//MARK: - public func MovieImageServiceProtocol
	public func getIcon(posterPath: String, completion: @escaping (Result<Data?, Error>) -> Void) {
		
		// проверяем наличия в кэше данных об ранее загруженной картинке
		if let imageCacheNSData = imageCache.object(forKey: posterPath as NSString) {
			completion(.success(imageCacheNSData as Data))
			
		} else {
			// если в кэше нет - делаем запрос, кэшируем картинку и возвращаем completion
			routerImageMovie.request(endPoint: .image(whith: MovieImageServiceConst.whith, posterPath: posterPath)) { [weak self] (data, response, error) in
				if let error = error {
					completion(.failure(error))
					return
				}
				if let data = data {
					self?.imageCache.setObject(data as NSData, forKey: posterPath as NSString)
					completion(.success(data))
				}
			}
		}
	}
}
