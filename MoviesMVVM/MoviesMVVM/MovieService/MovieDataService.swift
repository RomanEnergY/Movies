//
//  MovieDataService.swift
//  MoviesMVVM
//
//  Created by 1234 on 15.09.2020.
//  Copyright © 2020 ZRS. All rights reserved.
//

import Foundation

//MARK: - MovieDataServiceProtocol
protocol MovieDataServiceProtocol {
    func getTrending(completion: @escaping ([MainMovieProtocol]?) -> ()) -> Void
    func nextPage(completion: @escaping ([MainMovieProtocol]?) -> ()) -> Void
}

//MARK: - class MovieDataService: MovieDataServiceProtocol
final class MovieDataService: MovieDataServiceProtocol {
    //MARK: - private var
    private let timeWindows: MovieDataEndPoint.TimeWindows = .week
    private let networkService = NetworkService<MovieDataEndPoint>()
    private var currentPage: Int = 1
    
    //MARK: - public func MovieDataServiceProtocol
    public func getTrending(completion: @escaping ([MainMovieProtocol]?) -> ()) -> Void {
        networkService.request(route: .trending(timeWindows: timeWindows, page: currentPage)) { (data, response, error) in
            if let error = error {
                print("Error networkService.request:", error.localizedDescription)
                completion(nil)
                return
            }
            
            guard let data = data else {
                print("Error data: nil")
                completion(nil)
                
                return
            }
            
            do {
                let movieApiResponse = try JSONDecoder().decode(MovieResponseAPI.self, from: data)
                completion(movieApiResponse.movies)
                
            } catch {
                print("Error JSONDecoder().decode:", error.localizedDescription)
                completion(nil)
            }
        }
    }
    
    public func nextPage(completion: @escaping ([MainMovieProtocol]?) -> ()) {
        currentPage += 1
        getTrending {
            completion($0)
        }
    }
}
