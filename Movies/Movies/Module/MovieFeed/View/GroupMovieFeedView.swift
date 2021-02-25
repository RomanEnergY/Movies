//
//  GroupMovieFeedView.swift
//  Movies
//
//  Created by Roman Zverik on 24.02.2021.
//  Copyright © 2021 ZRS. All rights reserved.
//

import UIKit
import SnapKit

protocol GroupMovieFeedViewDelegate: class {
	func didSelectItemAt(index: Int)
}

final class GroupMovieFeedView: BaseView {
	
	private var data = [String]()
	private var activeRow: Int = 0
	private var collectionView: UICollectionView = {
		let layout = UICollectionViewFlowLayout()
		let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
		collection.showsHorizontalScrollIndicator = false
		layout.scrollDirection = .horizontal
		layout.minimumLineSpacing = 8
		layout.itemSize = CGSize(width: 100, height: 20)
		collection.translatesAutoresizingMaskIntoConstraints = false
		collection.backgroundColor = .clear
		
		return collection
	}()
	weak var delegate: GroupMovieFeedViewDelegate?
	
	override func configure() {
		backgroundColor = Dev.Color.create(colorType: .white)
		collectionView.dataSource = self
		collectionView.delegate = self
		
		registratinCell()
	}
	
	override func addSubviews() {
		addSubview(collectionView)
	}
	
	override func makeConstraints() {
		collectionView.snp.makeConstraints { make in
			make.top.bottom.equalToSuperview()
			make.height.equalTo(30)
			make.left.right.equalToSuperview()
		}
	}
	
	func update(data: [String]) {
		self.data = data
		
		collectionView.reloadData()
	}
	
	func select(number: Int) {
		activeRow = number
		collectionView.reloadData()
	}
	
	private func registratinCell() {
		let typeCell = SelectCollectionViewCell.self
		let reuseIdentifier = SelectCollectionViewCell.reuseIdentifier
		collectionView.register(typeCell, forCellWithReuseIdentifier: reuseIdentifier)
	}
}

extension GroupMovieFeedView: UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return data.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SelectCollectionViewCell.reuseIdentifier, for: indexPath) as! SelectCollectionViewCell
		cell.update(title: data[indexPath.row])
		cell.update(active: activeRow == indexPath.row)
		
		return cell
	}
}

extension GroupMovieFeedView: UICollectionViewDelegate {
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		if activeRow != indexPath.row {
			delegate?.didSelectItemAt(index: indexPath.row)
			collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
		}
	}
}
