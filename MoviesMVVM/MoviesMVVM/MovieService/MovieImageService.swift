//
//  MovieImageServiceProtocol.swift
//  MoviesMVVM
//
//  Created by 1234 on 15.09.2020.
//  Copyright © 2020 ZRS. All rights reserved.
//

import Foundation

//MARK: - MovieImageServiceProtocol
protocol MovieImageServiceProtocol {
    func getIcon(whith: Int, posterPath: String, completion: @escaping (Result<Data?, Error>) -> Void)
}

//MARK: - class MovieImageService: MovieImageServiceProtocol
final class MovieImageService: MovieImageServiceProtocol {
    //MARK: - private let
    private let routerImageMovie = NetworkService<MovieImageEndPoint>()

    //MARK: - public func MovieImageServiceProtocol
    public func getIcon(whith: Int, posterPath: String, completion: @escaping (Result<Data?, Error>) -> Void) {
        routerImageMovie.request(route: .image(whith: whith, posterPath: posterPath)) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            completion(.success(data))
        }
    }
}
