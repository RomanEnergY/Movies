//
//  ShadowRoundView.swift
//  Movies
//
//  Created by Roman Zverik on 19.02.2021.
//  Copyright © 2021 ZRS. All rights reserved.
//

import UIKit

final class ShadowRoundView: BaseView {
	
	private let image: UIImage?
	private let imageView = UIImageView()
	var shadowColor: UIColor = .black {
		didSet {
			updateView()
		}
	}
	var shadowOffset: CGSize = .zero {
		didSet {
			updateView()
		}
	}
	var shadowOpacity: CGFloat = 1.0 {
		didSet {
			updateView()
		}
	}
	var shadowRadius: CGFloat = 10.0 {
		didSet {
			updateView()
		}
	}
	var cornerRadius: CGFloat = 10.0 {
		didSet {
			updateView()
		}
	}
	
	//MARK: - inits
	
	init(image: UIImage?) {
		self.image = image
		super.init(frame: .zero)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	//MARK: - override function
	
	override func configure() {
		super.configure()
		
		imageView.image = image
		updateView()
	}
	
	override func addSubviews() {
		super.addSubviews()
		
		addSubview(imageView)
	}
	
	override func makeConstraints() {
		super.makeConstraints()
		
		imageView.snp.makeConstraints { make in
			make.edges.equalToSuperview()
		}
	}
	
	//MARK: - private function
	
	private func updateView() {
		layer.backgroundColor = UIColor.clear.cgColor
		layer.shadowColor = shadowColor.cgColor
		layer.shadowOffset = shadowOffset
		layer.shadowOpacity = Float(shadowOpacity)
		layer.shadowRadius = shadowRadius
		
		imageView.layer.cornerRadius = cornerRadius
		imageView.layer.masksToBounds = true
	}
}
