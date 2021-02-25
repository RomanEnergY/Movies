//
//  CollectionMovieFeedView.swift
//  Movies
//
//  Created by Roman Zverik on 25.02.2021.
//  Copyright © 2021 ZRS. All rights reserved.
//

import UIKit

protocol CollectionMovieFeedViewDelegate: class {
	func didSelect(id: Int)
	func fetchingNextPage()
}

final class CollectionMovieFeedView: BaseView {
	
	private var data = [MainModelMovieProtocol]()
	private var tableView: UITableView = {
		let view = UITableView()
		
		if #available(iOS 11.0, *) {
			view.contentInsetAdjustmentBehavior = .never
		}
		return view
	}()
	
	weak var delegate: CollectionMovieFeedViewDelegate?
	
	override func configure() {
		tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
		tableView.rowHeight = UITableView.automaticDimension
		tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
		
		tableView.dataSource = self
		tableView.delegate = self
		
		registratinCell()
	}
	
	override func addSubviews() {
		addSubview(tableView)
	}
	
	override func makeConstraints() {
		tableView.snp.makeConstraints { make in
			make.edges.equalToSuperview()
		}
	}
	
	func removeData() {
		self.data.removeAll()
		tableView.reloadData()
	}
	
	func append(data: [MainModelMovieProtocol]) {
		self.data.append(contentsOf: data)
		tableView.reloadData()
	}
	
	private func registratinCell() {
		let typeCell = CollectionTableViewCell.self
		let reuseIdentifier = CollectionTableViewCell.reuseIdentifier
		tableView.register(typeCell, forCellReuseIdentifier: reuseIdentifier)
	}
}

extension CollectionMovieFeedView: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return data.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: CollectionTableViewCell.reuseIdentifier, for: indexPath) as! CollectionTableViewCell
		cell.update(data: data[indexPath.row])
		
		return cell
	}
}

extension CollectionMovieFeedView: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		delegate?.didSelect(id: data[indexPath.row].id)
	}
	
	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		let offsetY = scrollView.contentOffset.y
		let contentHeight = scrollView.contentSize.height
		
		if (contentHeight - offsetY) < frame.height * 2 {
			delegate?.fetchingNextPage()
		}
	}
}
