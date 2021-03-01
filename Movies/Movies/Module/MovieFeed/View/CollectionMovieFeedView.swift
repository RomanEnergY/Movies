//
//  CollectionMovieFeedView.swift
//  Movies
//
//  Created by Roman Zverik on 25.02.2021.
//  Copyright © 2021 ZRS. All rights reserved.
//

import UIKit

protocol CollectionMovieFeedViewDelegate: class {
	func loadImage(posterPath: String, indexPath: IndexPath)
	func didSelect(id: Int)
	func fetchingNextPage()
}

final class CollectionMovieFeedView: BaseView {
	
	private var indexDataCache = [IndexPath: Data?]()
	private var indexViewCache = [IndexPath: ActivityImageView]()
	private var data = [MainModelMovieProtocol]()
	private let preloader = UIActivityIndicatorView()
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
		addSubview(preloader)
	}
	
	override func makeConstraints() {
		tableView.snp.makeConstraints { make in
			make.edges.equalToSuperview()
		}
		
		preloader.snp.makeConstraints { make in
			make.edges.equalTo(tableView)
		}
	}
	
	func updateImage(indexPath: IndexPath, data: Data?) {
		DispatchQueue.main.async { [weak self] in
//			self?.indexDataCache[indexPath] = data
			self?.indexViewCache[indexPath]?.update(imageData: data)
		}
	}
	
	func loading() {
		DispatchQueue.main.async { [weak self] in
			self?.preloader.startAnimating()
		}
	}
	
	func unLoading() {
		DispatchQueue.main.async { [weak self] in
			self?.preloader.stopAnimating()
		}
	}
	
	func removeData() {
		DispatchQueue.main.async { [weak self] in
			self?.data.removeAll()
			self?.indexViewCache.removeAll()
			self?.indexDataCache.removeAll()
			self?.reloadData()
		}
	}
	
	func append(data: [MainModelMovieProtocol]) {
		self.data.append(contentsOf: data)
		reloadData()
	}
	
	private func registratinCell() {
		let typeCell = CollectionTableViewCell.self
		let reuseIdentifier = CollectionTableViewCell.reuseIdentifier
		tableView.register(typeCell, forCellReuseIdentifier: reuseIdentifier)
	}
	
	private func reloadData() {
		DispatchQueue.main.async { [weak self] in
			self?.tableView.reloadData()
		}
	}
	
	private func reloadRows(at index: IndexPath) {
		DispatchQueue.main.async { [weak self] in
			self?.tableView.reloadRows(at: [index], with: .automatic)
		}
	}
}

extension CollectionMovieFeedView: UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return data.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionTableViewCell.reuseIdentifier, for: indexPath) as? CollectionTableViewCell else { return UITableViewCell() }
		
		cell.delegate = self
		cell.update(data: data[indexPath.row], indexPath: indexPath)
		
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

extension CollectionMovieFeedView: CollectionTableViewCellDelegate {
	
	//TODO: Проблема с кешированием
	func loadImage(cell: CollectionTableViewCell, posterPath: String, indexPath: IndexPath) {
		if let activityImageView = indexViewCache[indexPath],
		   let data = indexDataCache[indexPath] {
			activityImageView.update(imageData: data)
			
		}
		else {
			indexViewCache[indexPath] = cell.connectImageView()
			delegate?.loadImage(posterPath: posterPath, indexPath: indexPath)
		}
	}
}
