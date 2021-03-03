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
	private let logger: LoggerProtocol
	private let timeWindows: MovieDataEndPoint.TimeWindows = .week
	private let networkService = NetworkService<MovieDataEndPoint>()
	private var currentGroup: Group?
	private var currentPage: Int = 1
	
	init(
		logger: LoggerProtocol = DI.container.resolve(LoggerProtocol.self)
	) {
		self.logger = logger
	}
	
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
		
		// TODO: Блокировка запросов с 25.02.2021 со стороны российских серверов на домен https://api.themoviedb.org
		// Использование Stub объектов
		// После прекращения блокировки запросов метод getDataStub(_:) удалить - пользоваться методом getDataRequest(_:)
//		getDataStub(completion)
		
		// TODO: Начиная с 02.03.2021 запросы не блокируются
		getDataRequest(completion)
	}
	
	private func getDataRequest(_ completion: @escaping ([MainModelMovieProtocol]?) -> ()) {
		guard let group = currentGroup else { return }
		let endPoint = GroupToEndPoint.adapter(group, page: currentPage)
		
		networkService.request(endPoint: endPoint) { [weak self] (data, response, error) in
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
				self?.logger.log(.request, "movieApiResponse: \(movieApiResponse)")
				completion(movieApiResponse.movies)
				
			} catch {
				print("Error JSONDecoder().decode:", error.localizedDescription)
				completion(nil)
			}
		}
	}
	
	//TODO: искусственно замедляем ответ - для тестирования ui компонентов отображающих загрузку данных
	private func getDataStub(_ completion: @escaping ([MainModelMovieProtocol]?) -> ()) {
		do {
			guard let file = Bundle.main.url(forResource: "DataMoviesStub", withExtension: "json") else { return }
			let timeResult = 1.0
			
			let dataStub = try Data(contentsOf: file)
			let movieApiResponse = try JSONDecoder().decode(MovieResponseAPI.self, from: dataStub)
			logger.log(.requestStub, "movieApiResponseStub: \(movieApiResponse)")
			
			DispatchQueue.global(qos: .userInteractive).asyncAfter(deadline: .now() + timeResult) {
				completion(movieApiResponse.movies)
			}
			
		} catch {
			print("Error JSONDecoder().decode:", error.localizedDescription)
			completion(nil)
		}
	}
}
