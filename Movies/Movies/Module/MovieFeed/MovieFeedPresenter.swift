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
	func showLoading()
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
	
	func showLoading() {
		viewController?.display(viewState: .loading)
	}
}
