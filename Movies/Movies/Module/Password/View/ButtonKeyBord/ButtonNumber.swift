//
//  ButtonNumber.swift
//  Movies
//
//  Created by Roman Zverik on 23.02.2021.
//  Copyright © 2021 ZRS. All rights reserved.
//

import UIKit
import SnapKit

protocol ControlPressedDelegate: class {
	func controlPressed(devType: ButtonNumber.DevType)
}

class ButtonNumber: UIControl {
	
	enum DevType {
		case one
		case two
		case three
		case four
		case five
		case six
		case seven
		case eight
		case nine
		case stub
		case ziro
		case remove
	}
	
	//MARK: private variable
	
	private var devType: DevType
	private var colorHighlighted: UIColor {
		isHighlighted ? Dev.Color.create(colorType: .buttonNumberPressed) : Dev.Color.create(colorType: .white)
	}
	private var titleText: String {
		switch devType {
			case .one: return "1"
			case .two: return "2"
			case .three: return "3"
			case .four: return "4"
			case .five: return "5"
			case .six: return "6"
			case .seven: return "7"
			case .eight: return "8"
			case .nine: return "9"
			case .stub: return ""
			case .ziro: return "0"
			case .remove: return "<"
		}
	}
	private var descriptionText: String {
		switch devType {
			case .one: return ""
			case .two: return "а б в г"
			case .three: return "д е ж з"
			case .four: return "и й к л"
			case .five: return "м н о п"
			case .six: return "р с т у"
			case .seven: return "ф х ц ч"
			case .eight: return "ш щ ъ ы"
			case .nine: return "ь э ю я"
			case .stub: return ""
			case .ziro: return ""
			case .remove: return ""
		}
	}
	private var touchFrame: CGRect?
	private let titleLabel = UILabel()
	private let descriptionLabel = UILabel()
	
	//MARK: public variable
	
	weak var delegate: ControlPressedDelegate?
	
	//MARK: inits
	
	init(devType: DevType) {
		self.devType = devType
		super.init(frame: .zero)
		
		configure()
		addSubviews()
		makeConstraints()
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
	
	//MARK: public functions
	
	func configure() {
		titleLabel.text = titleText
		titleLabel.font = UIFont.systemFont(ofSize: UIScreen.main.bounds.height/25)
		titleLabel.textColor = Dev.Color.create(colorType: .black)
		titleLabel.textAlignment = .center
		
		descriptionLabel.text = descriptionText
		descriptionLabel.font = UIFont.systemFont(ofSize: UIScreen.main.bounds.height/60)
		descriptionLabel.textColor = Dev.Color.create(colorType: .buttonNumberDescriptionText)
		descriptionLabel.textAlignment = .center
		
		addTargetControlPressed()
		updateStyles()
	}
	
	func addSubviews() {
		addSubview(titleLabel)
		addSubview(descriptionLabel)
	}
	
	func makeConstraints() {
		titleLabel.snp.makeConstraints { make in
			make.center.equalToSuperview()
		}
		
		descriptionLabel.snp.makeConstraints { make in
			make.centerX.equalToSuperview()
			make.bottom.equalToSuperview().inset(5)
		}
	}
	
	//MARK: private functions
	
	private func updateStyles() {
		self.updateBorder()
		self.updateBackgroundColor()
	}
	
	private func updateBorder() {
		layer.cornerRadius = 20
		layer.masksToBounds = false
	}
	
	private func updateBackgroundColor() {
		switch devType {
			case .stub:
				break
			default:
				backgroundColor = colorHighlighted
		}
	}
	
	private func addTargetControlPressed() {
		switch devType {
			case .stub:
				break
			default:
				addTarget(self, action: #selector(controlPressed), for: .touchUpInside)
		}
	}
	
	@objc private func controlPressed() {
		delegate?.controlPressed(devType: devType)
	}
}
