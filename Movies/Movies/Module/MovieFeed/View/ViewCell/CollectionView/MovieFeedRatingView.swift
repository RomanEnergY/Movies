//
//  MovieFeedRatingView.swift
//  Movies
//
//  Created by Roman Zverik on 27.02.2021.
//  Copyright © 2021 ZRS. All rights reserved.
//

import UIKit

final class MovieFeedRatingView: BaseView {
	
	// MARK: - private var
	
	private let ratingLabel = UILabel()
	
	// MARK: - BaseView Lifecycle
	
	override func configure() {
		backgroundColor = Dev.Color.create(colorType: .white)
		layer.cornerRadius = 10
		layer.borderWidth = 1
		layer.masksToBounds = false
	}
	
	override func addSubviews() {
		addSubview(ratingLabel)
	}
	
	override func makeConstraints() {
		ratingLabel.snp.makeConstraints { make in
			make.edges.equalToSuperview().inset(5)
		}
	}
	
	//MARK: - public function
	
	func update(rating: String) {
		ratingLabel.text = rating
	}
}
