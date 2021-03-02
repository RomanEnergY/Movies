//
//  DescriptionPresenter.swift
//  Movies
//
//  Created by Roman Zverik on 15.09.2020.
//  Copyright © 2020 ZRS. All rights reserved.
//

import Foundation

//MARK: - DescriptionViewModelProtocol
protocol DescriptionViewModelProtocol {
	var descriptionMovie: DescriptionModelMovieProtocol? { get }
	var dataIcon: Data? { get }
	var tableViewReloadData: (() -> Void)? { get set }
}

//MARK: - DescriptionViewModel: DescriptionViewModelProtocol
final class DescriptionViewModel: DescriptionViewModelProtocol {
	
	//MARK: - public var DescriptionViewModelProtocol
	public var descriptionMovie: DescriptionModelMovieProtocol? {
		descriptionModel?.descriptionMovie
	}
	public var dataIcon: Data?
	public var tableViewReloadData: (() -> Void)?
	
	
	//MARK: -private var
	private var movieDesctiptionService: MovieDesctiptionServiceProtocol?
	private var movieImageService: MovieImageServiceProtocol?
	private var descriptionModel: DescriptionModelProtocol?
	private var router: RouterProtocol
	
	//MARK: - init
	init(router: RouterProtocol,
		 movie: MainModelMovieProtocol,
		 movieDesctiptionService: MovieDesctiptionServiceProtocol = MovieDesctiptionService(),
		 movieImageService: MovieImageServiceProtocol = MovieImageService()) {
		
		self.movieDesctiptionService = movieDesctiptionService
		self.movieImageService = movieImageService
		
		self.router = router
		initDescriptionMovie(movie.id)
		guard let iconString = movie.iconString else { return }
		initIconMovie(iconString)
	}
	
	//MARK: - private func
	private func initDescriptionMovie(_ idMovie: Int) {
		movieDesctiptionService?.getMovie(id: idMovie) { [weak self] result in
			guard let self = self else { return }
			
			switch result {
				case .success(let descriptionMovie):
					guard let descriptionMovie = descriptionMovie else { return }
					self.descriptionModel = DescriptionModel(descriptionMovie: descriptionMovie)
					
					DispatchQueue.main.async {
						self.tableViewReloadData?()
					}
					
				case .failure(let error):
					print(error)
			}
		}
	}
	
	private func initIconMovie(_ posterPath: String) {
		movieImageService?.getIcon(posterPath: posterPath, completion: { [weak self] result in
			guard let self = self else { return }
			
			switch result {
				case .success(let data):
					self.dataIcon = data
					
					DispatchQueue.main.async {
						self.tableViewReloadData?()
					}
					
				case .failure(let error):
					print(error)
			}
		})
	}
}
