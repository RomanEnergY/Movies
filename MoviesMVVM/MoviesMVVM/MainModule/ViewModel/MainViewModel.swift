//
//  MainPresenter.swift
//  MoviesMVVM
//
//  Created by 1234 on 15.09.2020.
//  Copyright © 2020 ZRS. All rights reserved.
//

import Foundation

protocol MainViewModelProtocol: AnyObject {
    var movies: [Movie] { get }
    var collectionViewReloadData: (() -> Void)? { get set }
//    var modelData: ModelData { get }
    
    func beginBatchFetch()
}

class MainViewModel: MainViewModelProtocol {
    //MARK: -public variable
    public var movies: [Movie] { modelData.allMovies }
    public var collectionViewReloadData: (() -> Void)?
    
    //MARK: -private variable
    private var fetchingMorePage = false
    private var modelData: ModelData
    
    init() {
        modelData = ModelData()
        getData()
    }
    
    private func getData() {
        modelData.getTrending(page: 1) { [weak self] in
            DispatchQueue.main.async {
                self?.collectionViewReloadData?()
            }
        }
    }
    
    public func beginBatchFetch() {
        if !fetchingMorePage {
            self.fetchingMorePage = true
                
                self.modelData.addDataNextPage() { [weak self] in
                    self?.fetchingMorePage = false
                    
                    DispatchQueue.main.async {
                        self?.collectionViewReloadData?()
                    }
            }
        }
    }
}
