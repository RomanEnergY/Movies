//
//  ActivityImageView.swift
//  Movies
//
//  Created by Roman Zverik on 26.02.2021.
//  Copyright © 2021 ZRS. All rights reserved.
//

import UIKit
import SnapKit

protocol ActivityImageViewDelegate: class {
	func loadImage(posterPath: String)
}

final class ActivityImageView: BaseView {
	
	enum State {
		case initial
		case loading
		case success
		case error
	}
	
	//MARK: private variable
	
	private var posterPath: String?
	private let iconView = UIImageView()
	private let preloaderIcon = UIActivityIndicatorView()
	private let titleLabel = UILabel()
	private let reloadButton = Dev.Button.create(devType: .error)
	
	//MARK: public variable
	
	weak var delegate: ActivityImageViewDelegate?
	private var state: ActivityImageView.State = .initial {
		didSet {
			if state == .initial {
				iconView.image = nil
			}
			preloaderIcon.isHidden = state != .loading
			state == .loading ? preloaderIcon.startAnimating() : preloaderIcon.stopAnimating()
			preloaderIcon.isHidden = state != .loading
			titleLabel.isHidden = state != .error
			reloadButton.isHidden = state != .error
			
			titleLabel.isHidden = false
			titleLabel.textColor = .red
			titleLabel.text = "\(state)"
		}
	}
	
	//MARK: life cycle
	
	override func configure() {
		iconView.backgroundColor = Dev.Color.create(colorType: .backgroundImage)
		titleLabel.font = UIFont.italicSystemFont(ofSize: 12)
		titleLabel.textAlignment = .center
		titleLabel.text = "Ошибка загрузки изображения"
		titleLabel.numberOfLines = 0
		
		reloadButton.setTitle("ПОВТОРИТЬ", for: .normal)
		reloadButton.titleLabel?.font = UIFont.italicSystemFont(ofSize: 12)
		reloadButton.addTarget(self, action: #selector(pressedButton), for: .touchUpInside)
		
		preloaderIcon.hidesWhenStopped = false
	}
	
	override func addSubviews() {
		addSubview(iconView)
		iconView.addSubview(preloaderIcon)
		iconView.addSubview(titleLabel)
		iconView.addSubview(reloadButton)
	}
	
	override func makeConstraints() {
		iconView.snp.makeConstraints { make in
			make.edges.equalToSuperview()
		}
		
		preloaderIcon.snp.makeConstraints { make in
			make.edges.equalToSuperview()
		}
		
		titleLabel.snp.makeConstraints { make in
			make.left.right.equalToSuperview().inset(20)
			make.centerY.equalToSuperview()
		}
		
		reloadButton.snp.makeConstraints { make in
			make.top.equalTo(titleLabel.snp.bottom).offset(5)
			make.centerX.equalTo(titleLabel)
			make.height.equalTo(25)
		}
	}
	
	//MARK: public function
	
	func resetState() {
		setState(mode: .initial)
	}
	
	func loading(posterPath: String?) {
		guard let posterPath = posterPath else { return }
		setState(mode: .loading)
		
		self.posterPath = posterPath
		// инициализация загрузки изображения
		delegate?.loadImage(posterPath: posterPath)
	}
	
	func update(imageData: Data?) {
		if let imageData = imageData {
			DispatchQueue.main.async { [weak self] in
				self?.iconView.image = UIImage(data: imageData)
				self?.setState(mode: self?.iconView.image != nil ? .success : .error)
			}
		}
		else {
			setState(mode: .error)
		}
	}
	
	//MARK: override function
	
	override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
		if state == .error, reloadButton.frame.contains(point) {
			return reloadButton
		}
		
		return super.hitTest(point, with: event)
	}
	
	override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
		if reloadButton.frame.contains(point) {
			return true
		}
		
		return super.point(inside: point, with: event)
	}
	
	//MARK: private function
	
	private func setState(mode: State) {
		DispatchQueue.main.async { [weak self] in
			self?.state = mode
		}
	}
	
	@objc private func pressedButton() {
		guard let posterPath = posterPath else { return }
		setState(mode: .loading)
		delegate?.loadImage(posterPath: posterPath)
	}
}
