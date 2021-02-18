//
//  BaseButton.swift
//  Movies
//
//  Created by Roman Zverik on 18.02.2021.
//  Copyright © 2021 ZRS. All rights reserved.
//

import UIKit

final class BaseButton: UIButton {
	
	//MARK: public variable
	
	enum DevType {
		case regular
	}
	
	var devType: DevType {
		didSet {
			updateStyles()
		}
	}
	
	//MARK: private variable
	
	private var buttonBackgroundColor: UIColor {
		switch self.devType {
			case .regular:
				return Dev.Color.create(colorType: .regular)
		}
	}
	
	private var buttonEnabledBackgroundColor: UIColor {
		return UIColor.gray
	}
	
	private var titleTextColor: UIColor {
		switch self.devType {
			case .regular:
				return Dev.Color.create(colorType: .black)
		}
	}
	
	private var titleEnabledTextColor: UIColor {
		return UIColor.gray
	}
	
	
	//MARK: inits
	
	init(devType: DevType) {
		self.devType = devType
		
		super.init(frame: .zero)
		
		self.titleLabel?.lineBreakMode = .byWordWrapping
		self.titleLabel?.textAlignment = .center
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	//MARK: override functions
	
	override func layoutSubviews() {
		super.layoutSubviews()
		self.updateStyles()
	}
	
	//MARK: private functions
	
	private func updateStyles() {
		self.updateBorder()
		self.updateTitleTextColor()
		self.updateBackgroundColor()
	}
	
	private func updateBorder() {
		switch self.devType {
			case .regular:
				layer.borderWidth = 3
				layer.borderColor = Dev.Color.create(colorType: .darkBlue).cgColor
				layer.cornerRadius = 10
				layer.shadowOpacity = 0
		}
		self.layer.masksToBounds = false
	}
	
	private func updateTitleTextColor() {
		titleLabel?.textColor = isEnabled ? titleTextColor : titleEnabledTextColor
	}
	
	private func updateBackgroundColor() {
		backgroundColor = isEnabled ? buttonBackgroundColor : buttonEnabledBackgroundColor
	}
}
