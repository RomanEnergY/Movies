//
//  MovieDescriptionIterator.swift
//  Movies
//
//  Created by Roman Zverik on 16.02.2021.
//  Copyright © 2021 ZRS. All rights reserved.
//

import Foundation

protocol MovieDescriptionBusinessLogic {
	func load(movieId: Int)
	func loadImage(posterPath: String)
}

final class MovieDescriptionIterator: MovieDescriptionBusinessLogic {
	
	// MARK: - private variable
	
	private let movieDesctiptionService: MovieDesctiptionServiceProtocol
	private let movieImageService: MovieImageServiceProtocol
	private let presenter: MovieDescriptionPresentationLogic
	
	init(
		presenter: MovieDescriptionPresentationLogic,
		movieDesctiptionService: MovieDesctiptionServiceProtocol = DI.container.resolve(MovieDesctiptionServiceProtocol.self),
		movieImageService: MovieImageServiceProtocol = DI.container.resolve(MovieImageServiceProtocol.self)
	) {
		self.presenter = presenter
		self.movieDesctiptionService = movieDesctiptionService
		self.movieImageService = movieImageService
	}
	
	func load(movieId: Int) {
		presenter.loading()
		movieDesctiptionService.getMovie(id: movieId) { [weak self] result in
			switch result {
				case .failure(let error):
					print(error.localizedDescription)
					
				case .success(let data):
					guard let data = data else { return }
					DispatchQueue.main.async {
						self?.presenter.unLoading()
						self?.presenter.update(descriptionModel: data)
					}
			}
		}
	}
	
	func loadImage(posterPath: String) {
		movieImageService.getIcon(posterPath: posterPath) { [weak self] result in
			switch result {
				case .failure(let error):
					print(error.localizedDescription)
					
				case .success(let data):
					self?.presenter.update(dataImage: data)
			}
		}
	}
}
