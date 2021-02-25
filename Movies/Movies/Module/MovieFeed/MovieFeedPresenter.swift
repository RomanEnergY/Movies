//
//  MovieFeedPresenter.swift
//  Movies
//
//  Created by Roman Zverik on 24.02.2021.
//  Copyright © 2021 ZRS. All rights reserved.
//

import Foundation

protocol MovieFeedPresentationLogic {
	func initialSelect(groups: [Group])
	func showSelectGroup(number: Int)
	func showLoading(number: Int)
	func showUnLoading(number: Int)
	func removeData()
	func loadingDataAppend(data: [MainModelMovieProtocol])
}

final class MovieFeedPresenter: MovieFeedPresentationLogic {
	
	weak var viewController: MovieFeedDisplayLogic?
	
	func initialSelect(groups: [Group]) {
		let data = groups.map { $0.rawValue }
		viewController?.display(viewState: .initialSelect(data: data))
	}
	
	func showSelectGroup(number: Int) {
		viewController?.display(viewState: .selectGroup(number: number))
	}
	
	func showLoading(number: Int) {
		viewController?.display(viewState: .loading(number: number))
	}
	
	func showUnLoading(number: Int) {
		viewController?.display(viewState: .unLoading(number: number))
	}
	
	func removeData() {
		viewController?.display(viewState: .removeData)
	}
	
	func loadingDataAppend(data: [MainModelMovieProtocol]) {
		viewController?.display(viewState: .append(data: data))
	}
}
