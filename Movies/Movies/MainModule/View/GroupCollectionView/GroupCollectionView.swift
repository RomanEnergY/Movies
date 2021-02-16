//
//  GroupCollectionView.swift
//  Movies
//
//  Created by Roman Zverik on 23.10.2020.
//  Copyright © 2020 ZRS. All rights reserved.
//

import UIKit

class GroupCollectionView: UICollectionView {
	
	//MARK: - public var
	public var groups: (() -> [Group])?
	public var getSelectedGroup: (() -> Group)?
	public var setSelectedGroup: ((Group) -> Void)?
	
	override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
		super.init(frame: frame, collectionViewLayout: layout)
		setup()
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		setup()
	}
	
	private func setup() {
		let nib = UINib(nibName: GroupCollectionViewCellConst.name, bundle: nil)
		register(nib, forCellWithReuseIdentifier: GroupCollectionViewCellConst.name)
		
		delegate = self
		dataSource = self
	}
}

extension GroupCollectionView: UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return groups?().count ?? 0
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GroupCollectionViewCellConst.name, for: indexPath) as? GroupCollectionViewCell {
			
			// устанавливаем данные в ячейку
			if let group = groups?()[indexPath.row] {
				cell.config(title: group.rawValue, isSelected: getSelectedGroup?() == group)
				
				return cell
			}
		} else {
			print("Error createGroupCollectionViewCell")
		}
		
		return UICollectionViewCell()
	}
}

extension GroupCollectionView: UICollectionViewDelegate {
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		
		if let groups = groups?() {
			setSelectedGroup?(groups[indexPath.row])
			scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
		}
	}
}

extension GroupCollectionView: UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		var size = CGSize()
		
		if let title = groups?()[indexPath.row].rawValue {
			let width = title.widthOfString(usingFont: UIFont.systemFont(ofSize: 17))
			size = CGSize(width: width + 20, height: 30)
		}
		
		return size
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
		return UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
	}
}

