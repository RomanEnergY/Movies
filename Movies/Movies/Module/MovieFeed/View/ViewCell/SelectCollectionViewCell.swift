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
	
	private let preloader = UIActivityIndicatorView()
	private let titleLabel = UILabel()
	private let activeView = UIView()
	private let activeColor = Dev.Color.create(colorType: .regular)
	private let notActiveColor = Dev.Color.create(colorType: .white)
	
	override func configure() {
		backgroundColor = notActiveColor
		titleLabel.font = UIFont.italicSystemFont(ofSize: 14)
		titleLabel.textAlignment = .center
		
		activeView.backgroundColor = notActiveColor
		activeView.layer.cornerRadius = 2
		activeView.layer.masksToBounds = false
	}
	
	override func addSubviews() {
		addSubview(preloader)
		addSubview(titleLabel)
		addSubview(activeView)
	}
	
	override func makeConstraints() {
		preloader.snp.makeConstraints { make in
			make.edges.equalToSuperview()
		}
		
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
	
	func update(title: String) {
		titleLabel.text = title
	}
	
	func update(active: Bool) {
		activeView.backgroundColor = active == true ? activeColor: notActiveColor
	}
	
	func loading() {
		preloader.startAnimating()
		titleLabel.isEnabled = false
	}
	
	func unLoading() {
		preloader.stopAnimating()
		titleLabel.isEnabled = true
	}
}
