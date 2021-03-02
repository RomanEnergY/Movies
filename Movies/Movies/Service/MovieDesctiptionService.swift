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
	func getMovie(id: Int, completion: @escaping (Result<DescriptionMovieModelProtocol?, Error>) -> ())
}

//MARK: - MovieDesctiptionService: MovieDesctiptionServiceProtocol
final class  MovieDesctiptionService: MovieDesctiptionServiceProtocol {
	
	//MARK: - private let
	private let networkService = NetworkService<MovieDataEndPoint>()
	
	//MARK: - public func MovieDesctiptionServiceProtocol
	public func getMovie(id: Int, completion: @escaping (Result<DescriptionMovieModelProtocol?, Error>) -> ()) {
		
		// если в кэше нет - делаем запрос, кэшируем картинку и возвращаем completion
		
		// TODO: Блокировка запросов с 25.02.2021 со стороны российских серверов на домен https://api.themoviedb.org
		// Использование Stub объектов
		// После прекращения блокировки запросов метод getDataStub(_:) удалить - пользоваться методом getDataRequest(_:, _:)
//		getDataStub(id, completion)
		
		// TODO: Начиная с 02.03.2021 запросы не блокируются
		getDataRequest(id, completion)
	}
	
	private func getDataRequest(_ id: Int, _ completion: @escaping (Result<DescriptionMovieModelProtocol?, Error>) -> ()) {
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
	
	private func getDataStub(_ id: Int, _ completion: @escaping (Result<DescriptionMovieModelProtocol?, Error>) -> ()) {
		do {
			guard let file = Bundle.main.url(forResource: "MovieDirectionStub", withExtension: "json") else {
				print("Error Bundle.main.url - forResource")
				return
			}
			let timeResult = 1.0
			
			let dataStub = try Data(contentsOf: file)
			let dataDecode = try JSONDecoder().decode(DescriptionMovieAPI.self, from: dataStub)
			
			DispatchQueue.global(qos: .userInteractive).asyncAfter(deadline: .now() + timeResult) {
				completion(.success(dataDecode))
			}
			
		} catch {
			print("Error JSONDecoder().decode:", error.localizedDescription)
			completion(.failure(error))
		}
	}
}
