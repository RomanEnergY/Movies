//
//  BeginningItemView.swift
//  Movies
//
//  Created by Roman Zverik on 20.02.2021.
//  Copyright © 2021 ZRS. All rights reserved.
//

import UIKit

final class BeginningItemView: BaseView {
	
	private let titleLabel = UILabel()
	private let stackView = UIStackView()
	
	override func configure() {
		super.configure()
		
		titleLabel.numberOfLines = 0
		stackView.axis = .vertical
		stackView.spacing = 5
	}
	
	func set(title: String) {
		titleLabel.text = title
	}
	
	func set(items: [String], separate: String) {
		items.forEach { item in
			let label = UILabel()
			label.numberOfLines = 0
			label.text = "\(separate) \(item)"
			stackView.addArrangedSubview(label)
		}
	}
	
	override func addSubviews() {
		super.addSubviews()
		
		addSubview(titleLabel)
		addSubview(stackView)
	}
	
	override func makeConstraints() {
		super.makeConstraints()
		
		titleLabel.snp.makeConstraints { make in
			make.left.top.right.equalToSuperview()
		}
		
		stackView.snp.makeConstraints { make in
			make.top.equalTo(titleLabel.snp.bottom).offset(10)
			make.left.right.bottom.equalToSuperview()
		}

	}
}
