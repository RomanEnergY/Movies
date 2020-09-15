//
//  ModelData.swift
//  MoviesMVVM
//
//  Created by 1234 on 15.09.2020.
//  Copyright © 2020 ZRS. All rights reserved.
//

import Foundation

class ModelData { // разбить на севисы
    // MARK: - Public properties
    var allMovies = [Movie]()
    
    // MARK: - Private properties
    private let withIcon = 300
    private var networkManager = NetworkManager() // protocol
    private var movieApiResponse: MovieApiResponse? // protocol
    private var pageСurrent: Int {
        get {
            guard let movieApiResponse = movieApiResponse else { return 1 }
            return movieApiResponse.currentPage
        }
    }
    private var totalPage: Int {
        get {
            guard let movieApiResponse = movieApiResponse else { return 1 }
            return movieApiResponse.totalPage
        }
    }
    
    //MARK: - public func
    public func addDataNextPage(complition: @escaping () -> Void) {
        getTrending(page: self.pageСurrent + 1) {
            complition()
        }
    }
    
    public func getTrending(page: Int, completion: @escaping () -> ()) {
        networkManager.getTrending(timeWindows: .week, page: page) { [weak self] result in
            switch result {
            case .failure(let error): print(error)
            case .success(let movieApiResponse):
                if let movieApiResponse = movieApiResponse {
                    self?.movieApiResponse = movieApiResponse
                    self?.allMovies.append(contentsOf: movieApiResponse.movies)
                }
                
                completion()
            }
        }
    }
    
    public func getIcon(whith: Int, posterPath: String, completion: @escaping (Result<Data?, Error>) -> Void) {
        self.networkManager.getImage(whith: whith, posterPath: posterPath) { result in
            switch result {
            case .failure(let error):
                print(error)
                
            case .success(let data):
                DispatchQueue.main.async {
                    completion(.success(data))
                }
            }
        }
    }
    
    func getMovieId(id: Int, completion: @escaping (Result<DescriptionMovie?, Error>) -> ()) {
        self.networkManager.getMovieId(id: id) { result in
            switch result {
            case .success(let descriptionMovie):
                DispatchQueue.main.sync {
                    completion(.success(descriptionMovie))
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
