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
		presenter.removeData()
		presenter.showLoadingCollection()
		presenter.showSelectGroup(number: item)
		presenter.showLoadingGroup(number: item)
		
		movieDataService.getDataNewGroup(group: groupsSelect[item]) { [weak self] result in
			self?.presenter.showUnLoadingGroup(number: item)
			self?.presenter.showUnLoadingCollection()
			
			switch result {
				case .failure(let error):
					print(error.localizedDescription)
				case .success(let model):
					if let model = model {
						self?.presenter.loadingDataAppend(data: model)
					}
					else {
						print("Data nil")
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
					self?.presenter.update(posterPath: posterPath, imageData: data)
			}
		}
	}
	
	func fetchingNextPage() {
		let selectGroup = tempSelectGroup
		presenter.showLoadingGroup(number: selectGroup)
		
		movieDataService.nextPage { [weak self] result in
			self?.presenter.showUnLoadingGroup(number: selectGroup)
			switch result {
				case .failure(let error):
					print(error.localizedDescription)
				case .success(let model):
					if let model = model {
						self?.presenter.loadingDataAppend(data: model)
					}
					else {
						print("Data nil")
					}
			}
		}
	}
}
