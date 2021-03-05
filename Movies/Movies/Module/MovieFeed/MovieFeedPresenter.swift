//
//  MovieFeedPresenter.swift
//  Movies
//
//  Created by Roman Zverik on 24.02.2021.
//  Copyright © 2021 ZRS. All rights reserved.
//

import Foundation

protocol MovieFeedPresentationLogic {
	func initialGroup(groups: [Group])
	func showLoadingGroup(number: Int)
	func showUnLoadingGroup(number: Int)
	func showSelectGroup(number: Int)
	
	func showLoadingCollection()
	func showUnLoadingCollection()
	func update(posterPath: String, imageData: Data?)
	func removeData()
	func loadingDataAppend(data: [MainModelMovieProtocol])
	
	func loadingServiceError(text: String)
}

final class MovieFeedPresenter: MovieFeedPresentationLogic {
	
	weak var viewController: MovieFeedDisplayLogic?
	
	func initialGroup(groups: [Group]) {
		let data = groups.map { $0.rawValue }
		viewController?.display(viewGroup: .initial(data: data))
	}
	
	func showLoadingGroup(number: Int) {
		viewController?.display(viewGroup: .loading(number: number))
	}
	
	func showUnLoadingGroup(number: Int) {
		viewController?.display(viewGroup: .unLoading(number: number))
	}
	
	func showSelectGroup(number: Int) {
		viewController?.display(viewGroup: .select(number: number))
	}
	
	func showLoadingCollection() {
		viewController?.display(viewCollection: .loading)
	}
	
	func showUnLoadingCollection() {
		viewController?.display(viewCollection: .unLoading)
	}
	
	func update(posterPath: String, imageData: Data?) {
		viewController?.display(viewCollection: .updateImage(posterPath: posterPath, data: imageData))
	}
	
	func removeData() {
		viewController?.display(viewCollection: .removeData)
	}
	
	func loadingDataAppend(data: [MainModelMovieProtocol]) {
		viewController?.display(viewCollection: .append(data: data))
	}
	
	func loadingServiceError(text: String) {
		viewController?.display(viewCollection: .loadingServiceError(text: text))
	}
}
