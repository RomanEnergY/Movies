//
//  MovieFeedView.swift
//  Movies
//
//  Created by Roman Zverik on 24.02.2021.
//  Copyright © 2021 ZRS. All rights reserved.
//

import UIKit
import SnapKit

protocol MovieFeedViewDelegate: class {
	func selectedGroup(item: Int)
	func loadImage(posterPath: String, reload: Bool)
	func selectMovie(id: Int)
	func fetchingNextPage()
}

final class MovieFeedView: BaseView {
	
	// MARK: - private var
	
	private var allBarsHeightConstraint: Constraint?
	private let preloader = UIActivityIndicatorView()
	private let errorView = ErrorView()
	private var groupMovieFeedView = GroupMovieFeedView()
	private var delimiterView = UIView()
	private var collectionMovieFeedView = CollectionMovieFeedView()
	
	// MARK: - public weak var
	
	weak var delegate: MovieFeedViewDelegate?

	// MARK: - BaseView Lifecycle
	
	override func configure() {
		backgroundColor = Dev.Color.create(colorType: .white)
		delimiterView.backgroundColor = Dev.Color.create(colorType: .gray)
		
		groupMovieFeedView.delegate = self
		collectionMovieFeedView.delegate = self
		
		errorView.isHidden = true
	}
	
	override func addSubviews() {
		addSubview(groupMovieFeedView)
		addSubview(delimiterView)
		addSubview(collectionMovieFeedView)
		addSubview(errorView)
		addSubview(preloader)
	}
	
	override func makeConstraints() {
		groupMovieFeedView.snp.makeConstraints { make in
			allBarsHeightConstraint = make.top.equalToSuperview().constraint
			make.left.right.equalToSuperview()
		}
		
		delimiterView.snp.makeConstraints { make in
			make.top.equalTo(groupMovieFeedView.snp.bottom)
			make.left.right.equalToSuperview()
			make.height.equalTo(1)
		}
		
		collectionMovieFeedView.snp.makeConstraints { make in
			make.top.equalTo(delimiterView.snp.bottom)
			make.left.right.bottom.equalToSuperview()
		}
		
		errorView.snp.makeConstraints { make in
			make.center.equalToSuperview()
		}
		
		preloader.snp.makeConstraints { make in
			make.center.equalToSuperview()
		}
	}
	
	// MARK: - override function
	
	override func layoutSubviews() {
		super.layoutSubviews()
		allBarsHeightConstraint?.update(inset: allBarsHeight)
	}
	
	// MARK: - public function
	
	func updateGroup(data: [String]) {
		groupMovieFeedView.update(data: data)
	}
	
	func updateGroup(number: Int) {
		groupMovieFeedView.select(number: number)
	}
	
	func loadingGroup(number: Int) {
		groupMovieFeedView.loading(number: number)
	}
	
	func unLoadingGroup(number: Int) {
		groupMovieFeedView.unLoading(number: number)
	}
	
	func updateImage(posterPath: String, data: Data?) {
		collectionMovieFeedView.updateImage(posterPath: posterPath, data: data)
	}
	
	func loadingCollection() {
		preloader.startAnimating()
	}
	
	func unLoadingCollection() {
		preloader.stopAnimating()
	}
	
	func presentRemoveData() {
		errorView.isHidden = true
		collectionMovieFeedView.isHidden = false
		collectionMovieFeedView.removeData()
	}
	
	func presentAppend(data: [MainModelMovieProtocol]) {
		errorView.isHidden = true
		collectionMovieFeedView.isHidden = false
		collectionMovieFeedView.append(data: data)
	}
	
	func loadingServiceError(text: String) {
		collectionMovieFeedView.isHidden = true
		errorView.isHidden = false
		errorView.update(text: text)
	}
}

extension MovieFeedView: GroupMovieFeedViewDelegate {
	func didSelectGroupItemAt(index: Int) {
		delegate?.selectedGroup(item: index)
	}
}

extension MovieFeedView: CollectionMovieFeedViewDelegate {
	func loadImage(posterPath: String, reload: Bool) {
		delegate?.loadImage(posterPath: posterPath, reload: reload)
	}
	
	func didSelect(id: Int) {
		delegate?.selectMovie(id: id)
	}
	
	func fetchingNextPage() {
		if groupMovieFeedView.loadingActiveCell.isEmpty {
			delegate?.fetchingNextPage()
		}
	}
}
