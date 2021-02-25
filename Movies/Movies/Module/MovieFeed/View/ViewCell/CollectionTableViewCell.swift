//
//  CollectionTableViewCell.swift
//  Movies
//
//  Created by Roman Zverik on 26.02.2021.
//  Copyright © 2021 ZRS. All rights reserved.
//

import UIKit
import SnapKit

final class CollectionTableViewCell: BaseTableViewCell {
	
	private let label = UILabel()
	
	override func configure() {
		
	}
	
	override func addSubviews() {
		addSubview(label)
	}
	
	override func makeConstraints() {
		label.snp.makeConstraints { make in
			make.top.equalToSuperview().inset(5)
			make.bottom.equalToSuperview().inset(5)
		}
	}
	
	func update(data: MainModelMovieProtocol) {
		label.text = data.title
	}
}
