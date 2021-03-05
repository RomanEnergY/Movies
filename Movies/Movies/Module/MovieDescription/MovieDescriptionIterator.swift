//
//  MovieDescriptionIterator.swift
//  Movies
//
//  Created by Roman Zverik on 16.02.2021.
//  Copyright © 2021 ZRS. All rights reserved.
//

import Foundation

protocol MovieDescriptionBusinessLogic {
	func load(movieId: Int, delay: Int)
	func loadImage(posterPath: String, reload: Bool)
	func reload()
}

extension MovieDescriptionBusinessLogic {
	func load(movieId: Int, delay: Int = 0) {
		load(movieId: movieId, delay: delay)
	}
}

final class MovieDescriptionIterator: MovieDescriptionBusinessLogic {
	
	// MARK: - private variable
	
	private let movieDesctiptionService: MovieDesctiptionServiceProtocol
	private let movieImageService: MovieImageServiceProtocol
	private let presenter: MovieDescriptionPresentationLogic
	private var tempMovieId = 0
	
	init(
		presenter: MovieDescriptionPresentationLogic,
		movieDesctiptionService: MovieDesctiptionServiceProtocol = DI.container.resolve(MovieDesctiptionServiceProtocol.self),
		movieImageService: MovieImageServiceProtocol = DI.container.resolve(MovieImageServiceProtocol.self)
	) {
		self.presenter = presenter
		self.movieDesctiptionService = movieDesctiptionService
		self.movieImageService = movieImageService
	}
	
	func load(movieId: Int, delay: Int = 0) {
		tempMovieId = movieId
		presenter.loading()
		
		DispatchQueue.global().asyncAfter(deadline: .now() + TimeInterval(delay)) { [weak self] in
			self?.movieDesctiptionService.getMovie(id: movieId) { result in
				self?.presenter.unLoading()
				switch result {
					case .failure(let error):
						self?.presenter.loadingServiceError(text: error.localizedDescription)
						
					case .success(let data):
						if let data = data {
							self?.presenter.update(descriptionModel: data)
						}
						else {
							print("Data nil")
						}
				}
			}
		}
	}
	
	func loadImage(posterPath: String, reload: Bool) {
		// если это повторная загрзка изображения - запрос сделать через 2 секунды
		let delay = reload ? 2 : 0
		DispatchQueue.global().asyncAfter(deadline: .now() + TimeInterval(delay)) { [weak self] in
			self?.movieImageService.getIcon(posterPath: posterPath) { result in
				switch result {
					case .failure(let error):
						print(error.localizedDescription)
						
					case .success(let data):
						self?.presenter.update(dataImage: data)
				}
			}
		}
	}
	
	func reload() {
		load(movieId: tempMovieId, delay: 2)
	}
}
