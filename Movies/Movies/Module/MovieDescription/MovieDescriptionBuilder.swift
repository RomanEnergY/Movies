//
//  MovieDescriptionBuilder.swift
//  Movies
//
//  Created by Roman Zverik on 16.02.2021.
//  Copyright © 2021 ZRS. All rights reserved.
//

import Foundation

final class MovieDescriptionBuilder: ModuleBuilder {
	
	struct Config {
		let movieId: Int
	}
	
	private let config: Config
	
	init() {
		fatalError("Use init with config")
	}
	
	init(config: Config) {
		self.config = config
	}
	
	func build() -> BaseViewController {
		let presenter = MovieDescriptionPresenter()
		let interactor = MovieDescriptionIterator(presenter: presenter)
		let controller = MovieDescriptionViewController(movieId: config.movieId, interactor: interactor)

		presenter.viewController = controller
		
		return controller
	}
}
