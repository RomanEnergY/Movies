//
//  CollectionTableViewCell.swift
//  Movies
//
//  Created by Roman Zverik on 26.02.2021.
//  Copyright © 2021 ZRS. All rights reserved.
//

import UIKit
import SnapKit

protocol CollectionTableViewCellDelegate: class {
	func load(dataImageView: DataImageViewProtocol, posterPath: String)
}

final class CollectionTableViewCell: BaseTableViewCell {
	
	private let contentCellView = UIView()
	private let contentCellShadowView = ShadowRoundView()
	private let activityImageView = ActivityImageView()
	private let imageShadowRoundView = ShadowRoundView()
	private let movieFeedContentView = MovieFeedContentView()
	private let ratingView = MovieFeedRatingView()
	
	weak var delegate: CollectionTableViewCellDelegate?
	
	override func configure() {
		super.configure()
		contentCellView.backgroundColor = Dev.Color.create(colorType: .lightGray)
		
		selectionStyle = .none
		
		contentCellShadowView.wrap(view: contentCellView)
		contentCellShadowView.shadowOpacity = 0.3
		contentCellShadowView.shadowRadius = 3.0
		
		imageShadowRoundView.wrap(view: activityImageView)
		imageShadowRoundView.shadowOpacity = 0.5
		imageShadowRoundView.shadowRadius = 5.0
		
		activityImageView.delegate = self
	}
	
	override func addSubviews() {
		super.addSubviews()
		
		addSubview(contentCellShadowView)
		contentCellShadowView.addSubview(contentCellView)
		
		contentCellView.addSubview(imageShadowRoundView)
		contentCellView.addSubview(ratingView)
		contentCellView.addSubview(movieFeedContentView)
	}
	
	override func makeConstraints() {
		super.makeConstraints()
		
		contentCellShadowView.snp.makeConstraints { make in
			make.top.bottom.equalToSuperview().inset(5)
			make.left.right.equalToSuperview().inset(10)
			make.height.equalTo(Int(UIScreen.main.bounds.width * 2/5))
		}
		
		imageShadowRoundView.snp.makeConstraints { make in
			make.top.equalTo(contentCellShadowView.snp.top)
			make.left.equalTo(contentCellShadowView.snp.left)
			make.bottom.equalTo(contentCellShadowView.snp.bottom)
			make.width.equalTo(contentCellShadowView.snp.height).multipliedBy(0.666) // 2/3
		}
		
		ratingView.snp.makeConstraints { make in
			make.right.equalTo(imageShadowRoundView.snp.right).offset(-5)
			make.bottom.equalTo(imageShadowRoundView.snp.bottom).offset(-5)
		}
		
		movieFeedContentView.snp.makeConstraints { make in
			make.left.equalTo(imageShadowRoundView.snp.right).offset(5)
			make.top.equalTo(imageShadowRoundView.snp.top)
			make.right.equalTo(contentCellShadowView.snp.right).offset(-5)
			make.bottom.equalTo(contentCellShadowView.snp.bottom).offset(-5)
		}
	}
	
	/// Обновление данных в ячейке и последующая инициализация загрузки изображения
	func update(data: MainModelMovieProtocol) {
		ratingView.update(rating: "\(data.rating)")
		movieFeedContentView.update(data: data)
		activityImageView.posterPath = data.posterPath
	}
}

extension CollectionTableViewCell: ActivityImageViewDelegate {
	func load(dataImageView: DataImageViewProtocol, posterPath: String) {
		delegate?.load(dataImageView: dataImageView, posterPath: posterPath)
	}
}
