//
//  MainView.swift
//  Movies
//
//  Created by Roman Zverik on 18.09.2020.
//  Copyright © 2020 ZRS. All rights reserved.
//

import UIKit

//MARK: - MainView: UIViewController
class MainView: UIViewController {
	//MARK: - IBOutlet
	@IBOutlet weak var groupCollectionView: GroupCollectionView!
	@IBOutlet weak var menuCollectionView: MenuCollectionView!
	
	//MARK: - public var
	public var viewModel: MainViewModelProtocol?
	
	//MARK: - override func
	override func viewDidLoad() {
		super.viewDidLoad()
		
		title = "MoviesGO"
		
		bindViewModel()
		bindGroupCollectionView()
		bindMenuCollectionView()
		
		viewModel?.initialStartData()
	}
	
	//MARK: - private func
	private func bindViewModel() {
		viewModel?.menuCollectionViewReloadData = { [weak self] in
			DispatchQueue.main.async {
				self?.menuCollectionView.reloadData()
			}
		}
		
		viewModel?.groupCollectionViewReloadData = { [weak self] in
			DispatchQueue.main.async {
				self?.groupCollectionView.reloadData()
			}
		}
	}
	
	private func bindMenuCollectionView() {
		menuCollectionView.movies = { [weak self] in
			self?.viewModel?.movies ?? []
		}
		
		menuCollectionView.initialImage = { [weak self] iconString, complition in
			guard let self = self else { return }
			self.viewModel?.getIcon(posterPath: iconString) { data in
				complition(data)
			}
		}
		
		menuCollectionView.showeDetail = { [weak self] movie in
			self?.viewModel?.showeDetail(movie: movie)
		}
		
		menuCollectionView.beginBatchFetch = { [weak self]  complition in
			self?.viewModel?.beginBatchFetch {
				complition()
			}
		}
	}
	
	private func bindGroupCollectionView() {
		groupCollectionView.groups = { [weak self] in
			self?.viewModel?.groups ?? []
		}
		
		groupCollectionView.setSelectedGroup = { [weak self] group in
			self?.viewModel?.selectedGroup = group
		}
		
		groupCollectionView.getSelectedGroup = { [weak self] in
			self?.viewModel?.selectedGroup ?? Group.nowPlaying
		}
	}
}
