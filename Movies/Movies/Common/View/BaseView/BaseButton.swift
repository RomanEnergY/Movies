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
		case error
	}
	
	var devType: DevType {
		didSet {
			updateStyles()
		}
	}
	
	//MARK: private variable
	
	private var buttonBackgroundColor: UIColor {
		switch self.devType {
			case .regular, .error:
				return isHighlighted ? Dev.Color.create(colorType: .regularPressed) : Dev.Color.create(colorType: .regular)
		}
	}
	private var titleTextColor: UIColor {
		return Dev.Color.create(colorType: .black)
	}
	private var enabledButtonBackgroundColor: UIColor { UIColor.gray }
	private var enabledTitleTextColor: UIColor { UIColor.gray }
	private var touchFrame: CGRect?
	
	
	//MARK: inits
	
	init(devType: DevType) {
		self.devType = devType
		
		super.init(frame: .zero)
		
		self.titleLabel?.lineBreakMode = .byWordWrapping
		self.titleLabel?.textAlignment = .center
		contentEdgeInsets = UIEdgeInsets(top: 2, left: 5, bottom: 2, right: 5)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	//MARK: override functions
	
	override var isHighlighted: Bool {
		didSet {
			self.updateTitleTextColor()
			self.updateBackgroundColor()
		}
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		self.updateStyles()
	}
	
	override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
		if let touchFrame = self.touchFrame, touchFrame.contains(point) {
			return self
		}
		
		return super.hitTest(point, with: event)
	}
	
	override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
		if let touchFrame = self.touchFrame {
			return touchFrame.contains(point)
		}
		
		return super.point(inside: point, with: event)
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
				layer.borderColor = Dev.Color.create(colorType: .border).cgColor
				layer.cornerRadius = 10
			case .error:
				layer.borderWidth = 1
				layer.borderColor = Dev.Color.create(colorType: .border).cgColor
				layer.cornerRadius = 5
		}
		self.layer.masksToBounds = false
	}
	
	private func updateTitleTextColor() {
		titleLabel?.textColor = isEnabled ? titleTextColor : enabledTitleTextColor
	}
	
	private func updateBackgroundColor() {
		backgroundColor = isEnabled ? buttonBackgroundColor : enabledButtonBackgroundColor
	}
}
