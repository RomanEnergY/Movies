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
	func loadImage(posterPath: String, reload: Bool)
}

final class MovieDescriptionView: BaseView {
	
	private let errorView = ErrorView()
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
		
		errorView.isHidden = true
	}
	
	override func addSubviews() {
		super.addSubviews()
		
		addSubview(bacgraundImage)
		addSubview(activityIndicatorView)
		addSubview(scrollView)
		addSubview(errorView)
		
		scrollView.addSubview(contentView)
		
		contentView.addSubview(imageShadowRoundView)
		contentView.addSubview(titleLabel)
		contentView.addSubview(overviewLabel)
		contentView.addSubview(releaseDateLabel)
	}
	
	override func makeConstraints() {
		super.makeConstraints()
		
		bacgraundImage.snp.makeConstraints { (make) in
			make.top.equalTo(safeAreaLayoutGuide.snp.top)
			make.left.right.bottom.equalToSuperview()
		}
		
		activityIndicatorView.snp.makeConstraints { (make) in
			make.edges.equalTo(bacgraundImage)
		}
		
		scrollView.snp.makeConstraints { (make) in
			make.edges.equalTo(bacgraundImage)
		}
		
		errorView.snp.makeConstraints { make in
			make.center.equalToSuperview()
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
			let deltaPoint = CGPoint(x: imageShadowRoundView.frame.minX + bacgraundImage.frame.minX - scrollView.contentOffset.x,
									 y: imageShadowRoundView.frame.minY + bacgraundImage.frame.minY - scrollView.contentOffset.y)
			
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
		scrollView.isHidden = true
		activityIndicatorView.startAnimating()
	}
	
	func unLoading() {
		activityIndicatorView.stopAnimating()
	}
	
	func update(model: DescriptionMovieModelProtocol) {
		activityIndicatorView.isHidden = true
		errorView.isHidden = true
		
		scrollView.isHidden = false
		activityImageView.posterPath = model.posterPath
		titleLabel.text = model.title
		overviewLabel.text = "\t\(model.overview)"
		
		if let releaseText = model.releaseDate?.formatter(dateFormat: "dd MMMM yyyy") {
			releaseDateLabel.text = "Дата выхода: \(releaseText)"
		}
	}
	
	func update(dataImage: Data?) {
		activityIndicatorView.isHidden = true
		errorView.isHidden = true
		
		scrollView.isHidden = false
		activityImageView.update(data: dataImage)
	}
	
	func loadingServiceError(text: String) {
		activityIndicatorView.isHidden = true
		scrollView.isHidden = true
		
		errorView.isHidden = false
		errorView.update(text: text)
	}
}

extension MovieDescriptionView: ActivityImageViewDelegate {
	func load(dataImageView: DataImageViewProtocol, posterPath: String, reload: Bool) {
		delegate?.loadImage(posterPath: posterPath, reload: reload)
	}
}
