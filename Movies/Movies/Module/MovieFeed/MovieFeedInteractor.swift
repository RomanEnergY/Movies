//
//  MovieFeedInteractor.swift
//  Movies
//
//  Created by Roman Zverik on 24.02.2021.
//  Copyright © 2021 ZRS. All rights reserved.
//

import Foundation

protocol MovieFeedBusinessLogic {
	func initialState()
	func selectGroup(item: Int)
}

final class MovieFeedInteractor: MovieFeedBusinessLogic {
	
	private let presenter: MovieFeedPresentationLogic
	private let movieDataService: MovieDataServiceProtocol
	
	init(
		presenter: MovieFeedPresentationLogic,
		movieDataService: MovieDataServiceProtocol = DI.container.resolve(MovieDataServiceProtocol.self)
	) {
		self.presenter = presenter
		self.movieDataService = movieDataService
	}
	
	func initialState() {
		presenter.initialSelect(groups: Group.allCases)
		presenter.showLoading()
		
		//TODO: обращаемся на сервер
		presenter.showSelectGroup(number: 1)
	}
	
	func selectGroup(item: Int) {
		
		//TODO: обращаемся на сервер
		print(item)
		presenter.showSelectGroup(number: item)
	}
}
