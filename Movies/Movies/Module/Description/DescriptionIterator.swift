//
//  DescriptionIterator.swift
//  Movies
//
//  Created by Roman Zverik on 16.02.2021.
//  Copyright © 2021 ZRS. All rights reserved.
//

import Foundation

protocol DescriptionBusinessLogic {
	func load(movieId: Int)
}

final class DescriptionIterator: DescriptionBusinessLogic {
	
	// MARK: - private variable
	
	private let movieDesctiptionService: MovieDesctiptionServiceProtocol
	private let presenter: DescriptionPresentationLogic
	
	init(
		presenter: DescriptionPresentationLogic,
		movieDesctiptionService: MovieDesctiptionServiceProtocol = DI.container.resolve(MovieDesctiptionServiceProtocol.self)
	) {
		self.presenter = presenter
		self.movieDesctiptionService = movieDesctiptionService
	}
	
	func load(movieId: Int) {
		presenter.loading()
		movieDesctiptionService.getMovie(id: movieId) { [weak self] result in
			switch result {
				case .failure(let error):
					print(error.localizedDescription)
					
				case .success(let data):
					guard let data = data else { return }
					self?.presenter.loading()
					self?.presenter.update(data: data)
			}
		}
	}
}
