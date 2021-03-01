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
	func loadImage(cell: CollectionTableViewCell, posterPath: String, indexPath: IndexPath)
}

final class CollectionTableViewCell: BaseTableViewCell {
	
	private let contentCellView = UIView()
	private let contentCellShadowView = ShadowRoundView()
	private let activityImageView = ActivityImageView()
	private let iconShadowView = ShadowRoundView()
	private let movieFeedContentView = MovieFeedContentView()
	private let ratingView = MovieFeedRatingView()
	private var indexPath: IndexPath?
	
	weak var delegate: CollectionTableViewCellDelegate?
	
	override func prepareForReuse() {
		activityImageView.resetState()
	}
	
	override func configure() {
		super.configure()
		contentCellView.backgroundColor = Dev.Color.create(colorType: .regular)
		
		selectionStyle = .none
		
		contentCellShadowView.wrap(view: contentCellView)
		contentCellShadowView.shadowOpacity = 0.5
		contentCellShadowView.shadowRadius = 5.0
		
		iconShadowView.wrap(view: activityImageView)
		iconShadowView.shadowOpacity = 0.5
		iconShadowView.shadowRadius = 5.0
		
		activityImageView.delegate = self
	}
	
	override func addSubviews() {
		super.addSubviews()
		
		addSubview(contentCellShadowView)
		contentCellShadowView.addSubview(contentCellView)
		
		contentCellView.addSubview(iconShadowView)
		contentCellView.addSubview(ratingView)
		contentCellView.addSubview(movieFeedContentView)
	}
	
	override func makeConstraints() {
		super.makeConstraints()
		
		contentCellShadowView.snp.makeConstraints { make in
			make.top.bottom.equalToSuperview().inset(5)
			make.left.right.equalToSuperview().inset(10)
			make.height.equalTo(Int(UIScreen.main.bounds.width * 3/5))
		}
		
		iconShadowView.snp.makeConstraints { make in
			make.top.equalTo(contentCellShadowView.snp.top).offset(5)
			make.left.equalTo(contentCellShadowView.snp.left).offset(5)
			make.bottom.equalTo(contentCellShadowView.snp.bottom).offset(-5)
			make.width.equalTo(Int(UIScreen.main.bounds.width * 2/5))
		}
		
		ratingView.snp.makeConstraints { make in
			make.right.equalTo(iconShadowView.snp.right).offset(-5)
			make.bottom.equalTo(iconShadowView.snp.bottom).offset(-5)
		}
		
		movieFeedContentView.snp.makeConstraints { make in
			make.left.equalTo(iconShadowView.snp.right).offset(5)
			make.top.equalTo(iconShadowView.snp.top)
			make.right.equalTo(contentCellShadowView.snp.right).offset(-5)
			make.bottom.equalTo(contentCellShadowView.snp.bottom).offset(-5)
		}
	}
	
	/// Обновление данных в ячейке и последующая инициализация загрузки изображения
	func update(data: MainModelMovieProtocol, indexPath: IndexPath) {
		self.indexPath = indexPath
		ratingView.update(rating: "\(data.rating)")
		movieFeedContentView.update(data: data)
		activityImageView.loading(posterPath: data.iconString)
	}
	
	func update(imageData: Data?) {
		activityImageView.update(imageData: imageData)
	}
	
	func connectImageView() -> ActivityImageView {
		return activityImageView
	}
}

extension CollectionTableViewCell: ActivityImageViewDelegate {
	func loadImage(posterPath: String) {
		guard let indexPath = indexPath else { return }
		delegate?.loadImage(cell: self, posterPath: posterPath, indexPath: indexPath)
	}
}
