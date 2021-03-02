//
//  DescriptionViewController.swift
//  Movies
//
//  Created by Roman Zverik on 16.02.2021.
//  Copyright © 2021 ZRS. All rights reserved.
//

import Foundation

protocol DescriptionDisplayLogic: class {
	func display(viewState: Description.ViewState)
}

final class DescriptionViewController: BaseViewController {
	
	// MARK: - private variable
	
	private let movieId: Int
	private let interactor: DescriptionBusinessLogic
//	private var customView = MovieFeedView()
	
	init(
		movieId: Int,
		interactor: DescriptionBusinessLogic
	) {
		self.movieId = movieId
		self.interactor = interactor
		super.init()
	}
	
	required public init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		interactor.load(movieId: movieId)
	}
}

extension DescriptionViewController: DescriptionDisplayLogic {
	func display(viewState: Description.ViewState) {
		
	}
}
