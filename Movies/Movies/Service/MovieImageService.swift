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
			
		}
		else {
			// если в кэше нет - делаем запрос, кэшируем картинку и возвращаем completion
			
			// TODO: Блокировка запросов с 25.02.2021 со стороны российских серверов на домен https://api.themoviedb.org/3/
			// Использование Stub объектов
			// После прекращения блокировки запросов метод getDataStub(_:) удалить - пользоваться методом getDataRequest(_:, _:)
			getDataStub(posterPath, completion)
			//			getDataRequest(posterPath, completion)
		}
	}
	
	private func getDataRequest(_ posterPath: String, _ completion: @escaping (Result<Data?, Error>) -> Void) {
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
	
	private func getDataStub(_ posterPath: String, _ completion: @escaping (Result<Data?, Error>) -> Void) {
		do {
			//TODO: искусственно замедляем ответ
			let random = Int.random(in: 0...4)
			let timeResult = 1.0
			
			guard let file = Bundle.main.url(forResource: "kino\(random)", withExtension: "png") else {
				print("nil stub image")
				DispatchQueue.global(qos: .userInteractive).asyncAfter(deadline: .now() + timeResult) {
					completion(.success(nil))
				}
				return
			}
			
			print("loading stub image")
			let dataStub = try Data(contentsOf: file)
			DispatchQueue.global(qos: .userInteractive).asyncAfter(deadline: .now() + timeResult) { [weak self] in
				self?.imageCache.setObject(dataStub as NSData, forKey: posterPath as NSString)
				completion(.success(dataStub))
			}
			
		} catch {
			print("Error JSONDecoder().decode:", error.localizedDescription)
			completion(.failure(error))
		}
	}
}
