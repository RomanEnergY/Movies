//
//  BaseTableViewCell.swift
//  Movies
//
//  Created by Roman Zverik on 26.02.2021.
//  Copyright © 2021 ZRS. All rights reserved.
//

import UIKit

class BaseTableViewCell: UITableViewCell {
	
	override public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		
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

extension BaseTableViewCell {
	public static var reuseIdentifier: String {
		return "\(self)"
	}
}
