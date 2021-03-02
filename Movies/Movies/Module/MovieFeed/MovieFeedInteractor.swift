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
	func loadImage(posterPath: String)
	func selectMovie(id: Int)
	func fetchingNextPageGroup(item: Int)
}

final class MovieFeedInteractor: MovieFeedBusinessLogic {
	
	private let presenter: MovieFeedPresentationLogic
	private let movieDataService: MovieDataServiceProtocol
	private let movieImageService: MovieImageServiceProtocol
	private let movieDesctiptionService: MovieDesctiptionServiceProtocol
	private let groupsSelect: [Group] = Group.allCases
	
	init(
		presenter: MovieFeedPresentationLogic,
		movieDataService: MovieDataServiceProtocol = DI.container.resolve(MovieDataServiceProtocol.self),
		movieImageService: MovieImageServiceProtocol = DI.container.resolve(MovieImageServiceProtocol.self),
		movieDesctiptionService: MovieDesctiptionServiceProtocol = DI.container.resolve(MovieDesctiptionServiceProtocol.self)
	) {
		self.presenter = presenter
		self.movieDataService = movieDataService
		self.movieImageService = movieImageService
		self.movieDesctiptionService = movieDesctiptionService
	}
	
	func initialState() {
		presenter.initialGroup(groups: groupsSelect)
		selectGroup(item: 0)
	}
	
	func selectGroup(item: Int) {
		presenter.showLoadingGroup(number: item)
		presenter.showLoadingCollection()
		presenter.removeData()
		
		movieDataService.getDataNewGroup(group: groupsSelect[item]) { [weak self] mainModelMovie in
			guard let self = self, let mainModelMovie = mainModelMovie else { return }
			self.presenter.loadingDataAppend(data: mainModelMovie)
			self.presenter.showUnLoadingGroup(number: item)
			self.presenter.showUnLoadingCollection()
		}
		presenter.showSelectGroup(number: item)
	}
	
	func loadImage(posterPath: String) {
		movieImageService.getIcon(posterPath: posterPath) { [weak self] result in
			switch result {
				case .failure(let error):
					print(error.localizedDescription)
					
				case .success(let data):
					self?.presenter.update(posterPath: posterPath, imageData: data)
			}
		}
	}
	
	func fetchingNextPageGroup(item: Int) {
		presenter.showLoadingGroup(number: item)
		movieDataService.nextPage { [weak self] mainModelMovie in
			guard let self = self, let mainModelMovie = mainModelMovie else { return }
			self.presenter.loadingDataAppend(data: mainModelMovie)
			self.presenter.showUnLoadingGroup(number: item)
		}
	}
	
	func selectMovie(id: Int) {
		movieDesctiptionService.getMovieId(id: id) { [weak self] result in
			switch result {
				case .failure(let error):
					print(error.localizedDescription)
					
				case .success(let data):
					guard let data = data else { return }
					self?.presenter.showSelectMovie(data: data)
			}
		}
	}
}
