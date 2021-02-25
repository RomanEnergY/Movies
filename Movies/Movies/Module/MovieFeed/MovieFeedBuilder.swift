//
//  MovieFeedBuilder.swift
//  Movies
//
//  Created by Roman Zverik on 24.02.2021.
//  Copyright © 2021 ZRS. All rights reserved.
//

import Foundation

final class MovieFeedBuilder: ModuleBuilder {
	
	func build() -> BaseViewController {
		let presenter = MovieFeedPresenter()
		let interactor = MovieFeedInteractor(presenter: presenter)
		let viewController = MovieFeedViewController(interactor: interactor)
		
		presenter.viewController = viewController
		return viewController
	}
}
