//
//  DevMenuAppParameterView.swift
//  Movies
//
//  Created by Roman Zverik on 08.03.2021.
//  Copyright © 2021 ZRS. All rights reserved.
//

import UIKit

protocol DevMenuAppParameterViewDelegate: class {
	
}

final class DevMenuAppParameterView: BaseView {
	
	// MARK: - private variables
	
	private let titleLabel = UILabel()
	
	// MARK: - public variables
	
	weak var delegate: DevMenuAppParameterViewDelegate?
	
	// MARK: - lifecycle
	
	override func configure() {
		super.configure()
		
		backgroundColor = Dev.Color.create(colorType: .white)
		
		titleLabel.text = "DevMenuAppParameterView"
		titleLabel.textAlignment = .center
	}
	
	override func addSubviews() {
		super.addSubviews()
		
		addSubview(titleLabel)
	}
	
	override func makeConstraints() {
		super.makeConstraints()
		
		titleLabel.snp.makeConstraints { make in
			make.top.equalTo(safeAreaLayoutGuide.snp.top)
			make.left.right.bottom.equalToSuperview()
		}
	}
	
}
