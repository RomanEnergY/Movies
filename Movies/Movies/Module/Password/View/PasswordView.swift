//
//  PasswordView.swift
//  Movies
//
//  Created by Roman Zverik on 22.02.2021.
//  Copyright © 2021 ZRS. All rights reserved.
//

import UIKit
import SnapKit

protocol PasswordViewDelegate: class {
	func keyPressed(key: PasswordView.Key)
}

final class PasswordView: BaseView {
	
	enum Key: String {
		case one = "1"
		case two = "2"
		case three = "3"
		case four = "4"
		case five = "5"
		case six = "6"
		case seven = "7"
		case eight = "8"
		case nine = "9"
		case ziro = "0"
		case remove = "<"
	}
	
	// MARK: - private variable
	
	private var allBarsHeightConstraint: Constraint?
	private let passwordStatusView = PasswordStatusView()
	private let keyBordView = KeyBordView()
	
	// MARK: - public variable
	
	weak var delegate: PasswordViewDelegate?
	
	// MARK: - override function
	
	override func configure() {
		backgroundColor = Dev.Color.create(colorType: .white)
		keyBordView.delegate = self
	}
	
	override func addSubviews() {
		addSubview(passwordStatusView)
		addSubview(keyBordView)
	}
	
	override func makeConstraints() {
		passwordStatusView.snp.makeConstraints { make in
			allBarsHeightConstraint = make.top.equalToSuperview().constraint
			make.left.right.equalToSuperview().inset(20)
		}
		
		keyBordView.snp.makeConstraints { make in
			let height = UIScreen.main.bounds.height
			make.top.equalToSuperview().inset(height * 0.5)
			make.left.right.bottom.equalToSuperview().inset(20)
		}
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		allBarsHeightConstraint?.update(inset: allBarsHeight + 50)
	}
	
	// MARK: - public function
	
	func updatePasswordKey(count: Int) {
		passwordStatusView.updatePasswordKey(count: count)
	}
	
	func keyNotInstalled() {
		passwordStatusView.keyNotInstalled()
	}
	
	func keyRepeat() {
		passwordStatusView.keyRepeat()
	}
	
	func errorInput() {
		passwordStatusView.errorInput()
	}
	
	func keyInstalled() {
		passwordStatusView.keyInstalled()
	}
	
	func updatePasswordKeyStatusView(count: Int) {
		passwordStatusView.updateKeyStatus(count: count)
	}

	
	// MARK: - private function
	
	private func transformDevTypeToKey(devType: ButtonNumber.DevType) -> PasswordView.Key? {
		switch devType {
			case .one: return .one
			case .two: return .two
			case .three: return .three
			case .four: return .four
			case .five: return .five
			case .six: return .six
			case .seven: return .seven
			case .eight: return .eight
			case .nine: return .nine
			case .ziro: return .ziro
			case .remove: return .remove
			default:
				return nil
		}
	}
}

// MARK: - KeyBordViewDelegate implementation

extension PasswordView: KeyBordViewDelegate {
	func controlPressed(devType: ButtonNumber.DevType) {
		guard let key = transformDevTypeToKey(devType: devType) else { return }
		delegate?.keyPressed(key: key)
	}
}
