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
}

final class MovieFeedView: BaseView {
	
	weak var delegate: MovieFeedViewDelegate?
	
	private var allBarsHeightConstraint: Constraint?
	private var groupCollectionView = GroupMovieFeedView()
	
	override func configure() {
		backgroundColor = Dev.Color.create(colorType: .white)
		
		groupCollectionView.delegate = self
	}
	
	override func addSubviews() {
		addSubview(groupCollectionView)
	}
	
	override func makeConstraints() {
		groupCollectionView.snp.makeConstraints { make in
			allBarsHeightConstraint = make.top.equalToSuperview().constraint
			make.left.right.equalToSuperview()
		}
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		allBarsHeightConstraint?.update(inset: allBarsHeight + 20)
	}
	
	func updateSelect(data: [String]) {
		groupCollectionView.update(data: data)
	}
	
	func select(groupNumber: Int) {
		groupCollectionView.select(number: groupNumber)
	}
	
	func loading() {
		print("MovieFeedView - loading")
	}
}

extension MovieFeedView: GroupMovieFeedViewDelegate {
	func didSelectItemAt(index: Int) {
		delegate?.selectedGroup(item: index)
	}
}
