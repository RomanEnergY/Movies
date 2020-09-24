//
//  MockMainViewModel.swift
//  MoviesMVVMTests
//
//  Created by 1234 on 22.09.2020.
//  Copyright © 2020 ZRS. All rights reserved.
//

import Foundation
@testable import MoviesMVVM

enum MockMainViewModelConst {
    static let movieStartData = MockMainMovie(id: 1, title: "t1", rating: 1.8, releaseDate: nil, iconString: nil, overview: "o")

    static let moviesData = [
        MockMainMovie(id: 2, title: "t2", rating: 1.2, releaseDate: nil, iconString: nil, overview: "over"),
        MockMainMovie(id: 3, title: "tt3", rating: 2.0, releaseDate: nil, iconString: nil, overview: "ove")
    ]
}

class MockMainViewModel: MainViewModel {
    public var checkShoweDetail = false
    
    override func initialStartData() {
        addMovie([MockMainViewModelConst.movieStartData])
        collectionViewReloadData?()
    }
    
    override func beginBatchFetch(complition: @escaping () -> Void) {
        addMovie(MockMainViewModelConst.moviesData)
        collectionViewReloadData?()
        complition()
    }
    
    override func showeDetail(movie: MainModelMovieProtocol) {
        checkShoweDetail = true
        super.showeDetail(movie: movie)
    }
}
