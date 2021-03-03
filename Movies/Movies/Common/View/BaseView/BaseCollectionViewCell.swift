//
//  BaseCollectionViewCell.swift
//  Movies
//
//  Created by Roman Zverik on 24.02.2021.
//  Copyright © 2021 ZRS. All rights reserved.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
	
	override public init(frame: CGRect) {
		super.init(frame: frame)
		
		addSubviews()
		makeConstraints()
		configure()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func addSubviews() { }
	func makeConstraints() { }
	func configure() { }
}

extension BaseCollectionViewCell {
	public static var reuseIdentifier: String {
		return "\(self)"
	}
}
