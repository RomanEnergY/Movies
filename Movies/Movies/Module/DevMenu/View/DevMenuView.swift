//
//  DevMenuView.swift
//  Movies
//
//  Created by Roman Zverik on 04.03.2021.
//  Copyright © 2021 ZRS. All rights reserved.
//

import UIKit

protocol DevMenuViewDelegate: class {
	
}

final class DevMenuView: BaseView {
	
	private let titleLabet = UILabel()
	
	weak var delegate: DevMenuViewDelegate?
	
	override func configure() {
		super.configure()
		
		backgroundColor = Dev.Color.create(colorType: .white)
		
		titleLabet.text = "DevMenuView"
		titleLabet.textAlignment = .center
		
	}
	
	override func addSubviews() {
		super.addSubviews()
		
		addSubview(titleLabet)
	}
	
	override func makeConstraints() {
		super.makeConstraints()
		
		titleLabet.snp.makeConstraints { make in
			make.edges.equalToSuperview()
		}
	}
}
