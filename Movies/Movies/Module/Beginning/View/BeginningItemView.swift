//
//  BeginningItemView.swift
//  Movies
//
//  Created by Roman Zverik on 20.02.2021.
//  Copyright © 2021 ZRS. All rights reserved.
//

import UIKit
import SnapKit

final class BeginningItemView: BaseView {
	
	private let titleLabel = UILabel()
	private let stackView = UIStackView()
	private var stackViewBottomConstraint: Constraint?
	
	override func configure() {
		super.configure()
		
		titleLabel.numberOfLines = 0
		stackView.axis = .vertical
	}
	
	func set(title: String, font: UIFont = UIFont.systemFont(ofSize: 14), alignment: NSTextAlignment = .natural) {
		titleLabel.text = title
		titleLabel.font = font
		titleLabel.textAlignment = alignment
		
		stackViewBottomConstraint?.update(inset: 0)
	}
	
	func set(items: [String], separate: String) {
		items.forEach { item in
			let label = UILabel()
			label.numberOfLines = 0
			label.font = UIFont.systemFont(ofSize: 16)
			label.text = "\(separate) \(item)"
			stackView.addArrangedSubview(label)
		}
		
		stackViewBottomConstraint?.update(offset: 10)
	}
	
	override func addSubviews() {
		super.addSubviews()
		
		addSubview(titleLabel)
		addSubview(stackView)
	}
	
	override func makeConstraints() {
		super.makeConstraints()
		
		titleLabel.snp.makeConstraints { make in
			make.top.equalToSuperview().inset(10)
			make.left.right.equalToSuperview()
		}
		
		stackView.snp.makeConstraints { make in
			make.top.equalTo(titleLabel.snp.bottom).offset(10)
			make.left.right.equalToSuperview()
			stackViewBottomConstraint = make.bottom.equalToSuperview().constraint
		}
	}
}
