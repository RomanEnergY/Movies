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
    func getIcon(posterPath: String, completion: @escaping (Result<Data?, Error>) -> Void)
}

//MARK: - MovieImageServiceConst
enum MovieImageServiceConst {
    static let whith = 300
}

//MARK: - class MovieImageService: MovieImageServiceProtocol
final class MovieImageService: MovieImageServiceProtocol {
    //MARK: - private let
    private let routerImageMovie = NetworkService<MovieImageEndPoint>()

    //MARK: - public func MovieImageServiceProtocol
    public func getIcon(posterPath: String, completion: @escaping (Result<Data?, Error>) -> Void) {
        routerImageMovie.request(route: .image(whith: MovieImageServiceConst.whith, posterPath: posterPath)) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            completion(.success(data))
        }
    }
}
