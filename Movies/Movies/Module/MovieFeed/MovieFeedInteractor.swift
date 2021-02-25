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
	func selectMovie(id: Int)
	func fetchingNextPageGroup(item: Int)
}

final class MovieFeedInteractor: MovieFeedBusinessLogic {
	
	private let presenter: MovieFeedPresentationLogic
	private let movieDataService: MovieDataServiceProtocol
	private let movieImageService: MovieImageServiceProtocol
	private let groupsSelect: [Group] = Group.allCases
	
	init(
		presenter: MovieFeedPresentationLogic,
		movieDataService: MovieDataServiceProtocol = DI.container.resolve(MovieDataServiceProtocol.self),
		movieImageService: MovieImageServiceProtocol = DI.container.resolve(MovieImageServiceProtocol.self)
	) {
		self.presenter = presenter
		self.movieDataService = movieDataService
		self.movieImageService = movieImageService
	}
	
	func initialState() {
		presenter.initialSelect(groups: groupsSelect)
		selectGroup(item: 0)
	}
	
	func selectGroup(item: Int) {
		presenter.showLoading(number: item)
		presenter.removeData()
		
		movieDataService.getDataNewGroup(group: groupsSelect[item]) { [weak self] mainModelMovie in
			guard let self = self,
				  let mainModelMovie = mainModelMovie else { return }
			DispatchQueue.global().asyncAfter(deadline: .now() + 0.5) {
				DispatchQueue.main.async {
					self.presenter.loadingDataAppend(data: mainModelMovie)
					self.presenter.showUnLoading(number: item)
				}
			}
		}
		
		presenter.showSelectGroup(number: item)
	}
	
	func selectMovie(id: Int) {
		print("MovieFeedInteractor: selectMovie: \(id)")
	}
	
	func fetchingNextPageGroup(item: Int) {
		presenter.showLoading(number: item)
		movieDataService.nextPage { [weak self] mainModelMovie in
			guard let self = self,
				  let mainModelMovie = mainModelMovie else { return }
			DispatchQueue.global().asyncAfter(deadline: .now() + 0.5) {
				DispatchQueue.main.async {
					self.presenter.loadingDataAppend(data: mainModelMovie)
					self.presenter.showUnLoading(number: item)
				}
			}
		}
	}
}
