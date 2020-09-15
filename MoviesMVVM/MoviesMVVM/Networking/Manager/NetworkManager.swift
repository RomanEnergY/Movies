//
//  NetworkManager.swift
//  MoviesMVVM
//
//  Created by 1234 on 15.09.2020.
//  Copyright © 2020 ZRS. All rights reserved.
//

import Foundation

struct NetworkManager {
    static let movieAPIKey = "794a530f52335c4139ed740dcd55a4ac"
    static let language = "ru-RU"
    private let routerMovieApi = Router<MovieApi>()
    private let routerImageMovie = Router<ImageMovie>()
    
    func getTrending(timeWindows: TimeWindows, page: Int, completion: @escaping (Result<MovieApiResponse?, Error>) -> ()) {
        routerMovieApi.request(route: .trending(timeWindows: timeWindows, page: page)) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
            }
            
            do {
                let dataDecode = try JSONDecoder().decode(MovieApiResponse.self, from: data!)
                completion(.success(dataDecode))
                
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    func getMovieId(id: Int, completion: @escaping (Result<DescriptionMovie?, Error>) -> ()) {
        routerMovieApi.request(route: .movieId(id: id)) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            do {
                let dataDecode = try JSONDecoder().decode(DescriptionMovie.self, from: data!)
                completion(.success(dataDecode))
                
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    func getMovieNowPlaying(page: Int, completion: @escaping (Result<Movie?, Error>) -> ()) {
        routerMovieApi.request(route: .movieNowPlaying(page: page)) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            do {
                let dataDecode = try JSONDecoder().decode(Movie.self, from: data!)
                completion(.success(dataDecode))
                
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    func getImage(whith: Int, posterPath: String, completion: @escaping (Result<Data?, Error>) -> ()) {
        routerImageMovie.request(route: .imageTmBD(whith: whith, posterPath: posterPath)) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            completion(.success(data))
        }
    }
    
    private func handleNetworkResponse(_ response: HTTPURLResponse) -> String {
        switch response.statusCode {
        case 200...299: return "Ok"
        case 401...500: return NetworkResponse.authenticationError.rawValue
        case 501...599: return NetworkResponse.badRequest.rawValue
        case 600: return NetworkResponse.outdated.rawValue
        default: return NetworkResponse.failed.rawValue
        }
    }
}

enum NetworkResponse: String {
    case success
    case authenticationError = "You need to be authenticated first."
    case badRequest = "Bad request."
    case outdated = "The url you requested is outdated."
    case failed = "Network request failed."
    case noData = "Response returned with no data to decode."
    case unableToDecode = "We could not decode the response."
}
