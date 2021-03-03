//
//  MovieDescriptionView.swift
//  Movies
//
//  Created by Roman Zverik on 02.03.2021.
//  Copyright © 2021 ZRS. All rights reserved.
//

import UIKit
import SnapKit

protocol MovieDescriptionViewDelegate: class {
	func loadImage(posterPath: String)
}

final class MovieDescriptionView: MainBaseView {
	
	private let bacgraundImage = UIImageView()
	private let activityIndicatorView = UIActivityIndicatorView()
	private let scrollView = UIScrollView()
	private let contentView = UIView()
	private let imageShadowRoundView = ShadowRoundView()
	private let activityImageView = ActivityImageView()
	private let titleLabel = UILabel()
	private let overviewLabel = UILabel()
	private let releaseDateLabel = UILabel()
	
	weak var delegate: MovieDescriptionViewDelegate?
	
	override func configure() {
		super.configure()
		
		backgroundColor = Dev.Color.create(colorType: .white)
		
		bacgraundImage.image = UIImage(named: "kino")
		bacgraundImage.alpha = 0.05
		
		imageShadowRoundView.wrap(view: activityImageView)
		imageShadowRoundView.shadowOpacity = 0.5
		imageShadowRoundView.shadowRadius = 5.0
		activityImageView.delegate = self
		
		titleLabel.font = UIFont.boldSystemFont(ofSize: 21)
		titleLabel.numberOfLines = 0
		titleLabel.textAlignment = .center
		
		overviewLabel.font = UIFont.italicSystemFont(ofSize: 16)
		overviewLabel.numberOfLines = 0
		
		releaseDateLabel.font = UIFont.italicSystemFont(ofSize: 12)
		releaseDateLabel.textAlignment = .right
	}
	
	override func addSubviews() {
		super.addSubviews()
		
		addSubview(bacgraundImage)
		addSubview(activityIndicatorView)
		addSubview(scrollView)
		
		scrollView.addSubview(contentView)
		
		contentView.addSubview(imageShadowRoundView)
		contentView.addSubview(titleLabel)
		contentView.addSubview(overviewLabel)
		contentView.addSubview(releaseDateLabel)
	}
	
	override func makeConstraints() {
		super.makeConstraints()
		
		bacgraundImage.snp.makeConstraints { (make) in
			allBarsHeightConstraint = make.top.equalToSuperview().constraint
			make.left.right.bottom.equalToSuperview()
		}
		
		activityIndicatorView.snp.makeConstraints { (make) in
			make.edges.equalTo(bacgraundImage)
		}
		
		scrollView.snp.makeConstraints { (make) in
			make.edges.equalTo(bacgraundImage)
		}
		
		contentView.snp.makeConstraints { (make) in
			make.edges.centerX.equalToSuperview()
		}

		imageShadowRoundView.snp.makeConstraints { make in
			make.top.equalTo(contentView.snp.top).offset(20)
			make.centerX.equalToSuperview()
			make.height.equalTo(Int(UIScreen.main.bounds.width))
			make.width.equalTo(imageShadowRoundView.snp.height).multipliedBy(0.666) // 2/3
		}
		
		titleLabel.snp.makeConstraints { make in
			make.top.equalTo(imageShadowRoundView.snp.bottom).offset(20)
			make.left.right.equalToSuperview().inset(20)
		}
		
		overviewLabel.snp.makeConstraints { make in
			make.top.equalTo(titleLabel.snp.bottom).offset(10)
			make.left.right.equalToSuperview().inset(20)
		}
		
		releaseDateLabel.snp.makeConstraints { make in
			make.top.equalTo(overviewLabel.snp.bottom).offset(10)
			make.left.right.equalToSuperview().inset(20)
			make.bottom.equalToSuperview().inset(20)
		}
	}
	
	override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
		if imageShadowRoundView.frame.contains(point) {
			let deltaPoint = CGPoint(x: imageShadowRoundView.frame.minX + bacgraundImage.frame.minX,
									 y: imageShadowRoundView.frame.minY + bacgraundImage.frame.minY)
			
			let pointImage = CGPoint(x: point.x - deltaPoint.x,
									 y: point.y - deltaPoint.y)
			return imageShadowRoundView.hitTest(pointImage, with: event)
		}
		
		return super.hitTest(point, with: event)
	}
	
	override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
		if imageShadowRoundView.frame.contains(point) {
			return true
		}
		
		return super.point(inside: point, with: event)
	}

	
	func loading() {
		DispatchQueue.main.async { [weak self] in
			self?.scrollView.isHidden = true
			self?.activityIndicatorView.isHidden = false
		}
	}
	
	func unLoading() {
		DispatchQueue.main.async { [weak self] in
			self?.scrollView.isHidden = false
			self?.activityIndicatorView.isHidden = true
		}
	}
	
	func update(model: DescriptionMovieModelProtocol) {
		activityImageView.posterPath = model.posterPath
		titleLabel.text = model.title
		overviewLabel.text = "\t\(model.overview)"
		
		if let releaseText = model.releaseDate?.formatter(dateFormat: "dd MMMM yyyy") {
			releaseDateLabel.text = "Дата выхода: \(releaseText)"
		}
	}
	
	func update(dataImage: Data?) {
		activityImageView.update(data: dataImage)
	}
}

extension MovieDescriptionView: ActivityImageViewDelegate {
	func load(dataImageView: DataImageViewProtocol, posterPath: String) {
		delegate?.loadImage(posterPath: posterPath)
	}
}
