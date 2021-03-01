//
//  MovieFeedRatingView.swift
//  Movies
//
//  Created by Roman Zverik on 27.02.2021.
//  Copyright © 2021 ZRS. All rights reserved.
//

import UIKit

final class MovieFeedRatingView: BaseView {
	
	private let ratingLabel = UILabel()
	
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
	
	func update(rating: String) {
		ratingLabel.text = rating
	}
}
