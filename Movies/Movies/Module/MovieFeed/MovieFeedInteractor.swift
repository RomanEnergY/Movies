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
	func selectGroup(item: Int, delay: Int)
	func loadImage(posterPath: String, reload: Bool)
	func fetchingNextPage()
	func reload()
}

extension MovieFeedBusinessLogic {
	func selectGroup(item: Int, delay: Int = 0) {
		selectGroup(item: item, delay: delay)
	}
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
	
	func selectGroup(item: Int, delay: Int = 0) {
		tempSelectGroup = item
		presenter.removeData()
		presenter.showLoadingCollection()
		presenter.showSelectGroup(number: item)
		presenter.showLoadingGroup(number: item)
		
		let group = groupsSelect[item]
		DispatchQueue.global().asyncAfter(deadline: .now() + TimeInterval(delay)) { [weak self] in
			self?.movieDataService.getDataNewGroup(group: group) { result in
				self?.presenter.showUnLoadingGroup(number: item)
				self?.presenter.showUnLoadingCollection()
				
				switch result {
					case .failure(let error):
						self?.presenter.loadingServiceError(text: error.localizedDescription)
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
	
	func loadImage(posterPath: String, reload: Bool) {
		// если это повторная загрзка изображения - запрос сделать через 2 секунды
		let delay = reload ? 2 : 0
		DispatchQueue.global().asyncAfter(deadline: .now() + TimeInterval(delay)) { [weak self] in
			self?.movieImageService.getIcon(posterPath: posterPath) { result in
				switch result {
					case .failure(let error):
						print(error.localizedDescription)
					case .success(let data):
						self?.presenter.update(posterPath: posterPath, imageData: data)
				}
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
	
	func reload() {
		//  повторяем запрос через 2 секунды
		selectGroup(item: tempSelectGroup, delay: 1)
	}
}
