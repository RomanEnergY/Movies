//
//  GroupCollectionViewCell.swift
//  Movies
//
//  Created by Roman Zverik on 25.09.2020.
//  Copyright © 2020 ZRS. All rights reserved.
//

import UIKit

// MARK: - enum GroupCollectionViewCellConst
enum GroupCollectionViewCellConst {
	static let name = "GroupCollectionViewCell"
}

// MARK: - GroupCollectionViewCell: UICollectionViewCell
class GroupCollectionViewCell: UICollectionViewCell {
	
	//MARK: - IBOutlet
	@IBOutlet weak var mainView: UIView! {
		didSet {
			mainView.layer.cornerRadius = 5
		}
	}
	@IBOutlet weak var titleLabel: UILabel!
	
	//MARK: - private var
	private var colorBacgraund = UIColor.white
	private var colorSelected = UIColor.systemGray5
	
	//MARK: - override func
	override func prepareForReuse() {
		super.prepareForReuse()
		
		mainView.backgroundColor = colorBacgraund
	}
	
	//MARK: - public func
	public func config(title: String, isSelected: Bool) {
		titleLabel.text = title
		if isSelected {
			mainView.backgroundColor = colorSelected
		}
	}
}
