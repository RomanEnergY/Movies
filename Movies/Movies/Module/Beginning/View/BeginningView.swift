//
//  BeginningView.swift
//  Movies
//
//  Created by Roman Zverik on 16.02.2021.
//  Copyright © 2021 ZRS. All rights reserved.
//

import UIKit

protocol BeginningViewDelegate: class {
	func continueButtonPressed()
}

final class BeginningView: BaseView {

	weak var delegate: BeginningViewDelegate?
	
	override func configure() {
		super.configure()
		
		let label =  UILabel()
		label.text = "BeginningView"
		label.frame = CGRect(origin: center, size: CGSize(width: 200, height: 20))
		
		let button = UIButton(type: .system)
		button.setTitle("Send", for: .normal)
		button.addTarget(self, action: #selector(continueButtonPressed), for: .touchUpInside)
		button.frame = CGRect(origin: CGPoint(x: label.frame.minX, y: label.frame.maxY + 10), size: CGSize(width: 100, height: 20))
		
		addSubview(label)
		addSubview(button)
	}

	override func addSubviews() {
		super.addSubviews()
		
	}

	override func makeConstraints() {
		super.makeConstraints()
		
	}

	@objc private func continueButtonPressed() {
		delegate?.continueButtonPressed()
	}
}
