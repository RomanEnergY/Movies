//
//  MainPresenter.swift
//  MoviesMVVM
//
//  Created by 1234 on 15.09.2020.
//  Copyright © 2020 ZRS. All rights reserved.
//

import Foundation

protocol MainPresenterProtocol: AnyObject {
    var movies: [Movie] { get }
//    var modelData: ModelData { get }
    
    func beginBatchFetch()
}

class MainPresenter: MainPresenterProtocol {
    //MARK: -public variable
    public var movies: [Movie] { modelData.allMovies }
    
    //MARK: -private variable
    private weak var view: MainViewProtocol?
    private var fetchingMorePage = false
    private var modelData: ModelData
    
    required init(mainViewProtocol: MainViewProtocol) {
        view = mainViewProtocol
        modelData = ModelData()
        getData()
    }
    
    private func getData() {
        modelData.getTrending(page: 1) { [weak self] in
            self?.beginBatchFetch()
        }
    }
    
    public func beginBatchFetch() {
        if !fetchingMorePage {
            self.fetchingMorePage = true
                
                self.modelData.addDataNextPage() { [weak self] in
                    self?.fetchingMorePage = false
                    
                    DispatchQueue.main.async {
                        self?.view?.collectionViewReloadData()
                    }
            }
        }
    }
}
