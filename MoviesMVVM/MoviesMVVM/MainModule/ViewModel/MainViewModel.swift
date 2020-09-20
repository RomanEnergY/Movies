//
//  MainPresenter.swift
//  MoviesMVVM
//
//  Created by 1234 on 15.09.2020.
//  Copyright © 2020 ZRS. All rights reserved.
//

import Foundation

//MARK: - MainViewModelProtocol
protocol MainViewModelProtocol: AnyObject {
    //MARK: - public variable
    var movies: [MainMovieProtocol]? { get }
    var collectionViewReloadData: (() -> Void)? { get set }
    
    //MARK: - public func
    func beginBatchFetch(complitionBatchFetch: @escaping () -> Void)
    func getIcon(whith: Int, posterPath: String, complition: @escaping ((Data) -> Void))
}

//MARK: - MainViewModel: MainViewModelProtocol
class MainViewModel: MainViewModelProtocol {
    
    //MARK: - public variable MainViewModelProtocol
    public var movies: [MainMovieProtocol]? {
        mainModel?.movies
    }
    public var collectionViewReloadData: (() -> Void)?
    
    //MARK: - private variable
    private var movieDataService: MovieDataServiceProtocol?
    private var movieImageService: MovieImageServiceProtocol?
    private var mainModel: MainModelProtocol?
    
    //MARK: - init
    init(mainModel: MainModelProtocol = MainModel(),
         movieDataService: MovieDataServiceProtocol = MovieDataService(),
         movieImageService: MovieImageServiceProtocol = MovieImageService()) {
        
        self.mainModel = mainModel
        self.movieDataService = movieDataService
        self.movieImageService = movieImageService
        
        initialStartData()
    }
    
    //MARK: - public func MainViewModelProtocol
    public func beginBatchFetch(complitionBatchFetch: @escaping () -> Void) {
        movieDataService?.nextPage(completion: { [weak self] mainMovies in
            if let mainMovies = mainMovies {
                self?.mainModel?.movies.append(contentsOf: mainMovies)
            }
            
            DispatchQueue.main.async {
                self?.collectionViewReloadData?()
                complitionBatchFetch()
            }
        })
    }
    
    public func getIcon(whith: Int, posterPath: String, complition: @escaping ((Data) -> Void)) {
        movieImageService?.getIcon(whith: whith, posterPath: posterPath) { result in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
                
            case .success(let data):
                guard let data = data else { return }
                complition(data)
            }
        }
    }
    
    //MARK: - private func
    private func initialStartData() {
        movieDataService?.getTrending(completion: { [weak self] mainMovies in
            guard let self = self,
                let mainMovies = mainMovies else { return }
            self.mainModel?.movies.append(contentsOf: mainMovies)
            
            DispatchQueue.main.async {
                self.collectionViewReloadData?()
            }
        })
    }
}
