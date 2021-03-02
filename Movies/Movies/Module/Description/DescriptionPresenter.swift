//
//  DescriptionPresenter.swift
//  Movies
//
//  Created by Roman Zverik on 16.02.2021.
//  Copyright © 2021 ZRS. All rights reserved.
//

import Foundation

protocol DescriptionPresentationLogic {
	func loading()
	func unLoading()
	func update(data: DescriptionMovieAPI)
}

final class DescriptionPresenter: DescriptionPresentationLogic {
	
	// MARK: - private variable
	
	weak var viewController: DescriptionDisplayLogic?
	
	func loading() {
		viewController?.display(viewState: .loading)
	}
	
	func unLoading() {
		viewController?.display(viewState: .unLoading)
	}
	
	func update(data: DescriptionMovieAPI) {
		viewController?.display(viewState: .update(data: data))
	}
}
