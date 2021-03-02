//
//  DescriptionBuilder.swift
//  Movies
//
//  Created by Roman Zverik on 16.02.2021.
//  Copyright © 2021 ZRS. All rights reserved.
//

import Foundation

final class DescriptionBuilder: ModuleBuilder {
	
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
		let presenter = DescriptionPresenter()
		let interactor = DescriptionIterator(presenter: presenter)
		let controller = DescriptionViewController(movieId: config.movieId, interactor: interactor)

		presenter.viewController = controller
		
		return controller
	}
}
