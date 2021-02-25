//
//  SelectCollectionViewCell.swift
//  Movies
//
//  Created by Roman Zverik on 24.02.2021.
//  Copyright © 2021 ZRS. All rights reserved.
//

import UIKit
import SnapKit

final class SelectCollectionViewCell: BaseCollectionViewCell {
	
	private var widthConstraint: Constraint?
	private var widthTextLabel: CGFloat = 0.0
	private let titleLabel = UILabel()
	private let activeView = UIView()
	private let activeColor = Dev.Color.create(colorType: .regular)
	private let notActiveColor = Dev.Color.create(colorType: .white)
	
	func update(title: String) {
		titleLabel.text = title
	}
	
	func update(active: Bool) {
		activeView.backgroundColor = active == true ? activeColor: notActiveColor
	}
	
	override func configure() {
		backgroundColor = notActiveColor
		titleLabel.font = UIFont.italicSystemFont(ofSize: 12)
		titleLabel.textAlignment = .center
		
		activeView.backgroundColor = notActiveColor
		activeView.layer.cornerRadius = 2
		activeView.layer.masksToBounds = false
	}
	
	override func addSubviews() {
		addSubview(titleLabel)
		addSubview(activeView)
	}
	
	override func makeConstraints() {
		titleLabel.snp.makeConstraints { make in
			make.top.equalToSuperview().inset(1)
			make.centerX.equalToSuperview()
		}
		
		activeView.snp.makeConstraints { make in
			make.top.equalTo(titleLabel.snp.bottom)
			make.centerX.equalToSuperview()
			make.width.equalTo(titleLabel.snp.width).offset(20)
			make.height.equalTo(3)
		}
	}
}
