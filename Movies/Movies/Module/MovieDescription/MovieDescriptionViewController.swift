//
//  DescriptionViewController.swift
//  Movies
//
//  Created by Roman Zverik on 16.02.2021.
//  Copyright © 2021 ZRS. All rights reserved.
//

import Foundation

protocol MovieDescriptionDisplayLogic: class {
	func display(viewState: MovieDescription.ViewState)
}

final class MovieDescriptionViewController: BaseViewController {
	
	// MARK: - private variable
	
	private let movieId: Int
	private let interactor: MovieDescriptionBusinessLogic
	private var customView = MovieDescriptionView()
	
	init(
		movieId: Int,
		interactor: MovieDescriptionBusinessLogic
	) {
		self.movieId = movieId
		self.interactor = interactor
		super.init()
	}
	
	required public init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		view = customView
		customView.delegate = self
		interactor.load(movieId: movieId)
	}
}

extension MovieDescriptionViewController: MovieDescriptionViewDelegate {
	func loadImage(posterPath: String, reload: Bool) {
		interactor.loadImage(posterPath: posterPath, reload: reload)
	}
}

extension MovieDescriptionViewController: MovieDescriptionDisplayLogic {
	func display(viewState: MovieDescription.ViewState) {
		switch viewState {
			case .loading:
				customView.loading()
			case .unLoading:
				customView.unLoading()
			case .update(let model):
				customView.update(model: model)
			case .updateImage(let data):
				customView.update(dataImage: data)
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
}

