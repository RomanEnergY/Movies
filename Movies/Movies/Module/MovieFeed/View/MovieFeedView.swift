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
	func loadImage(posterPath: String, indexPath: IndexPath)
	func selectMovie(id: Int)
	func fetchingNextPage(index: Int)
}

final class MovieFeedView: BaseView {
	
	weak var delegate: MovieFeedViewDelegate?
	
	private var allBarsHeightConstraint: Constraint?
	private var groupMovieFeedView = GroupMovieFeedView()
	private var delimiterView = UIView()
	private var collectionMovieFeedView = CollectionMovieFeedView()
	
	override func configure() {
		backgroundColor = Dev.Color.create(colorType: .white)
		delimiterView.backgroundColor = Dev.Color.create(colorType: .gray)
		
		groupMovieFeedView.delegate = self
		collectionMovieFeedView.delegate = self
	}
	
	override func addSubviews() {
		addSubview(groupMovieFeedView)
		addSubview(delimiterView)
		addSubview(collectionMovieFeedView)
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
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		allBarsHeightConstraint?.update(inset: allBarsHeight)
	}
	
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
	
	func updateImage(indexPath: IndexPath, data: Data?) {
		collectionMovieFeedView.updateImage(indexPath: indexPath, data: data)
	}
	
	func loadingCollection() {
		collectionMovieFeedView.loading()
	}
	
	func unLoadingCollection() {
		collectionMovieFeedView.unLoading()
	}
	
	func presentRemoveData() {
		collectionMovieFeedView.removeData()
	}
	
	func presentAppend(data: [MainModelMovieProtocol]) {
		collectionMovieFeedView.append(data: data)
	}
}

extension MovieFeedView: GroupMovieFeedViewDelegate {
	func didSelectGroupItemAt(index: Int) {
		delegate?.selectedGroup(item: index)
	}
}

extension MovieFeedView: CollectionMovieFeedViewDelegate {
	func loadImage(posterPath: String, indexPath: IndexPath) {
		delegate?.loadImage(posterPath: posterPath, indexPath: indexPath)
	}
	
	func didSelect(id: Int) {
		delegate?.selectMovie(id: id)
	}
	
	func fetchingNextPage() {
		if groupMovieFeedView.loadingActiveCell.isEmpty {
			let actionRow = groupMovieFeedView.activeRow
			delegate?.fetchingNextPage(index: actionRow)
		}
	}
}
