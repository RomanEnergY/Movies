//
//  ErrorView.swift
//  Movies
//
//  Created by Roman Zverik on 05.03.2021.
//  Copyright © 2021 ZRS. All rights reserved.
//

import UIKit

final class ErrorView: BaseView {
	
	// MARK: - private variables
	
	private let backgroundError = Dev.Color.create(colorType: .backgroundError)
	private let foregroundError = Dev.Color.create(colorType: .foregroundError)
	private let shadowRoundView = ShadowRoundView()
	private let contentView = UIView()
	private let titleLabel = UILabel()
	private let descriptionLabel = UILabel()
	
	// MARK: - lifecycle
	
	override func configure() {
		backgroundColor = backgroundError
		contentView.backgroundColor = foregroundError
		shadowRoundView.wrap(view: contentView)
		
		shadowRoundView.shadowOpacity = 0.3
		
		titleLabel.numberOfLines = 0
		titleLabel.font = UIFont.boldSystemFont(ofSize: 17)
		titleLabel.textAlignment = .center
		
		descriptionLabel.numberOfLines = 0
		descriptionLabel.font = UIFont.systemFont(ofSize: 14)
		descriptionLabel.textAlignment = .center
	}
	
	override func addSubviews() {
		addSubview(shadowRoundView)
		
		shadowRoundView.addSubview(contentView)
		
		contentView.addSubview(titleLabel)
		contentView.addSubview(descriptionLabel)
	}
	
	override func makeConstraints() {
		shadowRoundView.snp.makeConstraints { make in
			make.center.equalToSuperview()
			make.width.equalTo(Int(UIScreen.main.bounds.width * 4/6))
		}
		
		titleLabel.snp.makeConstraints { make in
			make.top.equalTo(shadowRoundView.snp.top).offset(10)
			make.left.equalTo(shadowRoundView.snp.left).offset(10)
			make.right.equalTo(shadowRoundView.snp.right).offset(-10)
		}
		
		descriptionLabel.snp.makeConstraints { make in
			make.top.equalTo(titleLabel.snp.bottom).offset(20)
			make.left.equalTo(shadowRoundView.snp.left).offset(10)
			make.right.equalTo(shadowRoundView.snp.right).offset(-10)
			make.bottom.equalTo(shadowRoundView.snp.bottom).offset(-10)
		}
	}
	
	// MARK: - public methods
	
	func update(text: String) {
		titleLabel.text = "Ошибка"
		descriptionLabel.text = text
	}
}
