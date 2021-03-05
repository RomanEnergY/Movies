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
	private let logger: LoggerProtocol
	private var imageCache: NSCache<NSString, NSData> // кэш (forKey: posterPath) -> data
	private let networkService = NetworkService<MovieImageEndPoint>()
	
	init(
		imageCache: NSCache<NSString, NSData>,
		logger: LoggerProtocol = DI.container.resolve(LoggerProtocol.self)
	) {
		self.imageCache = imageCache
		self.logger = logger
	}
	
	//MARK: - public func MovieImageServiceProtocol
	public func getIcon(posterPath: String, completion: @escaping (Result<Data?, Error>) -> Void) {
		
		// проверяем наличия в кэше данных об ранее загруженной картинке
		if let imageCacheNSData = imageCache.object(forKey: posterPath as NSString) {
			completion(.success(imageCacheNSData as Data))
			
		}
		else {
			// если в кэше нет - делаем запрос, кэшируем картинку и возвращаем completion
			
			// TODO: Блокировка запросов с 25.02.2021 со стороны российских серверов на домен https://api.themoviedb.org
			// Использование Stub объектов
			// После прекращения блокировки запросов метод getDataStub(_:) удалить - пользоваться методом getDataRequest(_:, _:)
//			getDataStub(posterPath, completion)
			
			// TODO: Начиная с 02.03.2021 запросы не блокируются
			getDataRequest(posterPath, completion)
		}
	}
	
	private func getDataRequest(_ posterPath: String, _ completion: @escaping (Result<Data?, Error>) -> Void) {
		networkService.request(endPoint: .image(whith: MovieImageServiceConst.whith, posterPath: posterPath)) { [weak self] result in
			switch result {
				case .failure(let error):
					completion(.failure(error))
				case .success(let data):
					self?.logger.log(.request, "imageData: \(String(describing: data))")
					if let imageData = data {
						self?.imageCache.setObject(imageData as NSData, forKey: posterPath as NSString)
						completion(.success(imageData))
					}
					else {
						completion(.success(nil))
					}
				
			}
		}
	}
	
	// Искусственно замедляем ответ - для тестирования ui компонентов отображающих загрузку данных
	// В ресурсах проекта есть 3 файла .png - для тестрирования загрузки изображения
	// Метод может вернуть nil объект - в дальнейшем пользователь должен инициализтровать повторную загрузку картинки
	private func getDataStub(_ posterPath: String, _ completion: @escaping (Result<Data?, Error>) -> Void) {
		do {
			let timeResult = 1.0
			let random = Int.random(in: 0...4)
			
			let file = Bundle.main.url(forResource: "kino\(random)", withExtension: "png")
			let imageDataStub: Data? = file != nil ? try Data(contentsOf: file!) : nil
			
			if let imageDataStub = imageDataStub {
				logger.log(.requestStub, "imageDataStub: \(imageDataStub)")
				imageCache.setObject(imageDataStub as NSData, forKey: posterPath as NSString)
			}
			
			DispatchQueue.global(qos: .userInteractive).asyncAfter(deadline: .now() + timeResult) {
				completion(.success(imageDataStub))
			}
			
		} catch {
			print("Error JSONDecoder().decode:", error.localizedDescription)
			completion(.failure(error))
		}
	}
}
