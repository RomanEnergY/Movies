//
//  MovieFeedViewController.swift
//  Movies
//
//  Created by Roman Zverik on 24.02.2021.
//  Copyright © 2021 ZRS. All rights reserved.
//

import Foundation

protocol MovieFeedDisplayLogic: class {
	func display(viewState: MovieFeed.ViewState)
}

final class MovieFeedViewController: BaseViewController {
	
	private let interactor: MovieFeedBusinessLogic
	private var customView = MovieFeedView()
	
	init(
		interactor: MovieFeedBusinessLogic
	) {
		self.interactor = interactor
		super.init()
	}
	
	required public init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		view = customView
		customView.delegate = self
		title = "MoviesGO"
		
		interactor.initialState()
	}
	
	//MARK: - private func
}

extension MovieFeedViewController: MovieFeedViewDelegate {
	func selectedGroup(item: Int) {
		interactor.selectGroup(item: item)
	}
	
	func selectMovie(id: Int) {
		interactor.selectMovie(id: id)
	}
	
	func fetchingNextPage(index: Int) {
		interactor.fetchingNextPageGroup(item: index)
	}
}

extension MovieFeedViewController: MovieFeedDisplayLogic {
	func display(viewState: MovieFeed.ViewState) {
		switch viewState {
			case .initialSelect(let data):
				customView.updateGroup(data: data)
			case .selectGroup(let number):
				customView.updateGroup(number: number)
			case .loading(let number):
				customView.loading(number: number)
			case .unLoading(let number):
				customView.unLoading(number: number)
			case .removeData:
				customView.presentRemoveData()
			case .append(let data):
				customView.presentAppend(data: data)
		}
	}
}
