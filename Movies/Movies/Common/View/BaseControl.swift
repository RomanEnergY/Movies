//
//  ButtonNumber.swift
//  Movies
//
//  Created by Roman Zverik on 23.02.2021.
//  Copyright © 2021 ZRS. All rights reserved.
//

import UIKit

class ButtonNumber: UIControl {
	
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
	
	private var colorHighlighted: UIColor {
		isHighlighted ? Dev.Color.create(colorType: .regularPressed) : Dev.Color.create(colorType: .regular)
	}
	private var colorTitleText: UIColor {
		Dev.Color.create(colorType: .black)
	}
	private var enabledButtonBackgroundColor: UIColor { UIColor.gray }
	private var enabledTitleTextColor: UIColor { UIColor.gray }
	private var touchFrame: CGRect?
	private let title: String
	private let descriptionText: String
	
	//MARK: inits
	
	init(title: String, descriptionText: String) {
		self.title = title
		self.descriptionText = descriptionText
		
		super.init(frame: .zero)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	//MARK: override functions
	
	override var isHighlighted: Bool {
		didSet {
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
		self.updateBackgroundColor()
	}
	
	private func updateBorder() {
		switch self.devType {
			case .regular:
				layer.borderWidth = 3
				layer.borderColor = Dev.Color.create(colorType: .regularBorder).cgColor
				layer.cornerRadius = 10
				layer.shadowOpacity = 0
		}
		self.layer.masksToBounds = false
	}
	
	private func updateBackgroundColor() {
		backgroundColor = isEnabled ? buttonBackgroundColor : enabledButtonBackgroundColor
	}
}
