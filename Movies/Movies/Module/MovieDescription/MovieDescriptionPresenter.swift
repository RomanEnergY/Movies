//
//  MovieDescriptionPresenter.swift
//  Movies
//
//  Created by Roman Zverik on 16.02.2021.
//  Copyright © 2021 ZRS. All rights reserved.
//

import Foundation

protocol MovieDescriptionPresentationLogic {
	func loading()
	func unLoading()
	func update(descriptionModel: DescriptionMovieModelProtocol)
	func update(dataImage: Data?)
	func loadingServiceError(text: String)
}

final class MovieDescriptionPresenter: MovieDescriptionPresentationLogic {
	
	// MARK: - private variable
	
	weak var viewController: MovieDescriptionDisplayLogic?
	
	func loading() {
		viewController?.display(viewState: .loading)
	}
	
	func unLoading() {
		viewController?.display(viewState: .unLoading)
	}
	
	func update(descriptionModel: DescriptionMovieModelProtocol) {
		viewController?.display(viewState: .update(model: descriptionModel))
	}
	
	func update(dataImage: Data?) {
		viewController?.display(viewState: .updateImage(data: dataImage))
	}
	
	func loadingServiceError(text: String) {
		viewController?.display(viewState: .loadingServiceError(text: text))
	}
}
