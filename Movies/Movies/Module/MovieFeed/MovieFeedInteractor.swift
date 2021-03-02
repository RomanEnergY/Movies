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
	func fetchingNextPage()
}

final class MovieFeedInteractor: MovieFeedBusinessLogic {
	
	private let presenter: MovieFeedPresentationLogic
	private let movieDataService: MovieDataServiceProtocol
	private let movieImageService: MovieImageServiceProtocol
	private let groupsSelect: [Group] = Group.allCases
	private var tempSelectGroup: Int = 0
	
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
		presenter.initialGroup(groups: groupsSelect)
		selectGroup(item: tempSelectGroup)
	}
	
	func selectGroup(item: Int) {
		tempSelectGroup = item
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
	
	func fetchingNextPage() {
		presenter.showLoadingGroup(number: tempSelectGroup)
		movieDataService.nextPage { [weak self] mainModelMovie in
			guard let self = self, let mainModelMovie = mainModelMovie else { return }
			self.presenter.loadingDataAppend(data: mainModelMovie)
			self.presenter.showUnLoadingGroup(number: self.tempSelectGroup)
		}
	}
}
