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
