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
	func display(viewGroup: MovieFeed.ViewState.Group)
	func display(viewCollection: MovieFeed.ViewState.Collection)
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
	
	func loadImage(posterPath: String, reload: Bool) {
		interactor.loadImage(posterPath: posterPath, reload: reload)
	}
	
	func selectMovie(id: Int) {
		display(viewState: .showDescription(movieId: id))
	}
	
	func fetchingNextPage() {
		interactor.fetchingNextPage()
	}
}

extension MovieFeedViewController: MovieFeedDisplayLogic {
	func display(viewGroup: MovieFeed.ViewState.Group) {
		switch viewGroup {
			case .initial(let data):
				customView.updateGroup(data: data)
			case .select(let number):
				customView.updateGroup(number: number)
			case .loading(let number):
				customView.loadingGroup(number: number)
			case .unLoading(let number):
				customView.unLoadingGroup(number: number)
		}
	}
	
	func display(viewCollection: MovieFeed.ViewState.Collection) {
		switch viewCollection {
			case .loading:
				customView.loadingCollection()
			case .unLoading:
				customView.unLoadingCollection()
			case let .updateImage(posterPath, data):
				customView.updateImage(posterPath: posterPath, data: data)
			case .removeData:
				customView.presentRemoveData()
			case .append(let data):
				customView.presentAppend(data: data)
			case .loadingServiceError(let text):
				showAlert(text: text,
						  actionReload: { [weak self] action in
							self?.interactor.reload()
						  },
						  actionCancel: { [weak self] action in
							self?.customView.loadingServiceError(text: text)
						  })
		}
	}
	
	func display(viewState: MovieFeed.ViewState) {
		switch viewState {
			case .showDescription(let movieId):
				appNavigator.go(module: MovieDescriptionBuilder(config: .init(movieId: movieId)), mode: .push(animated: true))
		}
	}
}
