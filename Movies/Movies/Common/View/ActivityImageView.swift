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
	func update(data: Data?)
}

final class ActivityImageView: BaseView, DataImageViewProtocol {
	
	enum State {
		case initial
		case loading
		case success
		case error
	}
	
	//MARK: private variable
	
	private let imageView = UIImageView()
	private let preloaderIcon = UIActivityIndicatorView()
	private let titleLabel = UILabel()
	private let reloadButton = Dev.Button.create(devType: .error)
	
	//MARK: public variable
	
	weak var delegate: ActivityImageViewDelegate?
	var posterPath: String? {
		didSet {
			if posterPath != nil {
				setState(mode: .loading)
			}
		}
	}
	private var state: ActivityImageView.State = .initial {
		didSet {
			if state == .initial {
				imageView.image = nil
			}
			state == .loading ? preloaderIcon.startAnimating() : preloaderIcon.stopAnimating()
			preloaderIcon.isHidden = state != .loading
			titleLabel.isHidden = state != .error
			reloadButton.isHidden = posterPath == nil ? true : state != .error
			
			if state == .loading {
				imageView.image = nil
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
		titleLabel.text = "Ошибка"
		titleLabel.numberOfLines = 0
		titleLabel.isHidden = true
		
		reloadButton.setTitle("ПОВТОРИТЬ", for: .normal)
		reloadButton.titleLabel?.font = UIFont.italicSystemFont(ofSize: 10)
		reloadButton.addTarget(self, action: #selector(pressedButton), for: .touchUpInside)
		reloadButton.isHidden = true
		
		preloaderIcon.hidesWhenStopped = false
		preloaderIcon.isHidden = true
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
			make.left.right.equalToSuperview().inset(5)
			make.centerY.equalToSuperview()
		}
		
		reloadButton.snp.makeConstraints { make in
			make.top.equalTo(titleLabel.snp.bottom).offset(5)
			make.centerX.equalTo(titleLabel)
			make.height.equalTo(20)
		}
	}
	
	//MARK: public function
	
	func viewWillAppear() {
		setState(mode: .loading)
	}
	
	func update(data: Data?) {
		let image: UIImage? = data != nil ? UIImage(data: data!) : nil
		
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
