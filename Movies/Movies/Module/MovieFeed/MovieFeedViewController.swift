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
}

extension MovieFeedViewController: MovieFeedDisplayLogic {
	func display(viewState: MovieFeed.ViewState) {
		switch viewState {
			case .initialSelect(let data):
				customView.updateSelect(data: data)
			case .selectGroup(let number):
				customView.select(groupNumber: number)
			case .loading:
				customView.loading()
		}
	}
}
