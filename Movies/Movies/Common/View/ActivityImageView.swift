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
	func load(dataImageView: DataImageViewProtocol, posterPath: String)
}

protocol DataImageViewProtocol {
	func update(image: UIImage?)
}

final class ActivityImageView: BaseView, DataImageViewProtocol {
	
	enum State {
		case initial
		case loading
		case success
		case error
	}
	
	//MARK: private variable
	
	private var posterPath: String?
	private let imageView = UIImageView()
	private let preloaderIcon = UIActivityIndicatorView()
	private let titleLabel = UILabel()
	private let reloadButton = Dev.Button.create(devType: .error)
	
	//MARK: public variable
	
	weak var delegate: ActivityImageViewDelegate?
	private var state: ActivityImageView.State = .initial {
		didSet {
			if state == .initial {
				imageView.image = nil
			}
			state == .loading ? preloaderIcon.startAnimating() : preloaderIcon.stopAnimating()
			preloaderIcon.isHidden = state != .loading
			titleLabel.isHidden = state != .error
			reloadButton.isHidden = posterPath == nil ? true : state != .error
			
			titleLabel.isHidden = false
			titleLabel.textColor = .red
			titleLabel.text = "\(state)"
			
			if state == .loading {
				if let posterPath = posterPath {
					self.delegate?.load(dataImageView: self, posterPath: posterPath)
				}
			}
		}
	}
	
	//MARK: life cycle
	
	override func configure() {
		imageView.backgroundColor = Dev.Color.create(colorType: .backgroundImage)
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
		addSubview(imageView)
		imageView.addSubview(preloaderIcon)
		imageView.addSubview(titleLabel)
		imageView.addSubview(reloadButton)
	}
	
	override func makeConstraints() {
		imageView.snp.makeConstraints { make in
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
		if state != .loading {
			setState(mode: .initial)
		}
	}
	
	func loading(posterPath: String?) {
		guard let posterPath = posterPath, state != .loading else { return }
		self.posterPath = posterPath
		setState(mode: .loading)
	}
	
	func update(image: UIImage?) {
		if let image = image {
			setState(mode: .success)
			DispatchQueue.main.async { [weak self] in
				self?.imageView.image = image
			}
		}
		else {
			setState(mode: .error)
		}
	}
	
	//MARK: override function
	
	override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
		if !reloadButton.isHidden, reloadButton.frame.contains(point) {
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
		setState(mode: .loading)
	}
}
