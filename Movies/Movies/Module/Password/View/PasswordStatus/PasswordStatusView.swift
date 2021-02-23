//
//  PasswordStatusView.swift
//  Movies
//
//  Created by Roman Zverik on 23.02.2021.
//  Copyright © 2021 ZRS. All rights reserved.
//

import UIKit

final class PasswordStatusView: BaseView {
	
	private let title = UILabel()
	private let passwordStatusPressedView = PasswordStatusCircleView()
	
	// MARK: - override func
	
	override func configure() {
		title.font = UIFont.systemFont(ofSize: 14)
		title.textAlignment = .center
	}
	
	override func addSubviews() {
		addSubview(title)
		addSubview(passwordStatusPressedView)
	}
	
	override func makeConstraints() {
		title.snp.makeConstraints { make in
			make.top.equalToSuperview()
			make.left.right.equalToSuperview()
		}
		
		passwordStatusPressedView.snp.makeConstraints { make in
			make.top.equalTo(title.snp.bottom).offset(50)
			make.centerX.equalToSuperview()
			make.width.equalTo(200)
		}
	}
	
	// MARK: - public function
	
	func updatePasswordKey(count: Int) {
		passwordStatusPressedView.updatePasswordKey(count: count)
	}
	
	func keyNotInstalled() {
		title.text = "Придумайте пароль"
	}
	
	func keyRepeat() {
		title.text = "Повторите пароль"
	}
	
	func errorInput() {
		passwordStatusPressedView.errorInput()
	}
	
	func keyInstalled() {
		title.text = "Введите пароль"
	}
	
	func updateKeyStatus(count: Int) {
		passwordStatusPressedView.updateColorView(count: count)
	}
}
