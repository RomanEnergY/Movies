//
//  DescriptionPresenter.swift
//  MoviesMVVM
//
//  Created by 1234 on 15.09.2020.
//  Copyright © 2020 ZRS. All rights reserved.
//

import Foundation

protocol DescriptionPresenterProtocol: AnyObject {
    var descriptionMovie: DescriptionMovie? { get }
    var dataIcon: Data? { get }
}

class DescriptionPresenter: DescriptionPresenterProtocol {
    var descriptionMovie: DescriptionMovie?
    var dataIcon: Data?
    
    private weak var view: DescriptionViewProtocol?
    private var modelData: ModelData?
    private var idMovie: Int
    private var posterPath: String
    
    
    required init(descriptionViewProtocol: DescriptionViewProtocol, idMovie: Int, posterPath: String) {
        view = descriptionViewProtocol
        self.modelData = ModelData()
        self.idMovie = idMovie
        self.posterPath = posterPath
        
        guard let modelData = modelData else { return }
        initDescriptionMovie(modelData: modelData)
        initIconMovie(modelData: modelData)
    }
    
    private func initDescriptionMovie(modelData: ModelData) {
        modelData.getMovieId(id: idMovie) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let descriptionMovie):
                self.descriptionMovie = descriptionMovie
                self.view?.tableViewReloadData()
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func initIconMovie(modelData: ModelData) {
        modelData.getIcon(whith: 300, posterPath: posterPath, completion: { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                self.dataIcon = data
                self.view?.tableViewReloadData()
                
            case .failure(let error):
                print(error)
            }
        })
    }
    
}
