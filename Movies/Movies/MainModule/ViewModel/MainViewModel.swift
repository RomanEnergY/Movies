//
//  MainPresenter.swift
//  Movies
//
//  Created by Roman Zverik on 15.09.2020.
//  Copyright © 2020 ZRS. All rights reserved.
//

import Foundation

//MARK: - MainViewModelProtocol
protocol MainViewModelProtocol {
	
	//MARK: - public variable
	var groups: [Group]? { get }
	var movies: [MainModelMovieProtocol]? { get }
	var menuCollectionViewReloadData: (() -> Void)? { get set }
	var groupCollectionViewReloadData: (() -> Void)? { get set }
	var selectedGroup: Group? { get set }
	
	//MARK: - public func
	func initialStartData()
	func beginBatchFetch(complition: @escaping () -> Void)
	func getIcon(posterPath: String, complition: @escaping ((Data) -> Void))
	func showeDetail(movie: MainModelMovieProtocol)
}

//MARK: - MainViewModel: MainViewModelProtocol
class MainViewModel: MainViewModelProtocol {
	
	//MARK: - public variable MainViewModelProtocol
	public var groups: [Group]? { mainModel?.groups }
	public var selectedGroup: Group? {
		didSet {
			if self.selectedGroup != nil && oldValue != selectedGroup {
				selectedNewGroup()
				
			} else {
				selectedGroup = oldValue
			}
		}
	}
	public var movies: [MainModelMovieProtocol]? { mainModel?.movies }
	public var menuCollectionViewReloadData: (() -> Void)?
	public var groupCollectionViewReloadData: (() -> Void)?
	
	//MARK: - private variable
	private var movieDataService: MovieDataServiceProtocol?
	private var movieImageService: MovieImageServiceProtocol?
	private var mainModel: MainModelProtocol?
	private var router: RouterProtocol
	
	//MARK: - init
	init(router: RouterProtocol,
		 mainModel: MainModelProtocol = MainModel(),
		 movieDataService: MovieDataServiceProtocol = MovieDataService(),
		 movieImageService: MovieImageServiceProtocol = MovieImageService()) {
		
		self.router = router
		self.mainModel = mainModel
		self.movieDataService = movieDataService
		self.movieImageService = movieImageService
	}
	
	//MARK: - public func MainViewModelProtocol
	public func initialStartData() {
		selectedGroup = groups?.first
	}
	
	public func beginBatchFetch(complition: @escaping () -> Void) {
		movieDataService?.nextPage(completion: { [weak self] mainMovies in
			if let mainMovies = mainMovies {
				self?.mainModel?.movies.append(contentsOf: mainMovies)
			}
			
			DispatchQueue.main.async {
				self?.menuCollectionViewReloadData?()
				complition()
			}
		})
	}
	
	public func getIcon(posterPath: String, complition: @escaping ((Data) -> Void)) {
		movieImageService?.getIcon(posterPath: posterPath) { result in
			switch result {
				case .failure(let error):
					print(error.localizedDescription)
					
				case .success(let data):
					guard let data = data else { return }
					complition(data)
			}
		}
	}
	
	public func showeDetail(movie: MainModelMovieProtocol) {
		router.showDetailViewMovie(movie: movie)
	}
	
	//MARK: - internal func
	internal func addMovie(_ mainMovies: [MainModelMovieProtocol]) {
		mainModel?.movies.append(contentsOf: mainMovies)
	}
	
	//MARK: - private func
	private func selectedNewGroup() {
		guard let selectedGroup = self.selectedGroup else { return }
		
		self.mainModel?.movies = []
		self.menuCollectionViewReloadData?()
		
		movieDataService?.getDataNewGroup(group: selectedGroup) { [weak self] mainMovies in
			guard let self = self,
				  let mainMovies = mainMovies else { return }
			self.addMovie(mainMovies)
			
			self.menuCollectionViewReloadData?()
			self.groupCollectionViewReloadData?()
		}
	}
}
