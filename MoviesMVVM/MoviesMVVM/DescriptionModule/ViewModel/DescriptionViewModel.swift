//
//  DescriptionPresenter.swift
//  MoviesMVVM
//
//  Created by 1234 on 15.09.2020.
//  Copyright © 2020 ZRS. All rights reserved.
//

import Foundation

protocol DescriptionViewModelProtocol {
    var descriptionMovie: DescriptionMovie? { get }
    var dataIcon: Data? { get }
    var tableViewReloadData: (() -> Void)? { get set }
}

final class DescriptionViewModel: DescriptionViewModelProtocol {
    //MARK: -public var
    public var descriptionMovie: DescriptionMovie?
    public var dataIcon: Data?
    public var tableViewReloadData: (() -> Void)?
    
    //MARK: -private var
    private var modelData: ModelData?
    private var idMovie: Int
    private var posterPath: String
    
    //MARK: -required init
    required init(idMovie: Int, posterPath: String) {
        self.modelData = ModelData()
        self.idMovie = idMovie
        self.posterPath = posterPath
        
        guard let modelData = modelData else { return }
        initDescriptionMovie(modelData: modelData)
        initIconMovie(modelData: modelData)
    }
    
    //MARK: -private func
    private func initDescriptionMovie(modelData: ModelData) {
        modelData.getMovieId(id: idMovie) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let descriptionMovie):
                self.descriptionMovie = descriptionMovie
                self.tableViewReloadData?()
                
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
                self.tableViewReloadData?()
                
            case .failure(let error):
                print(error)
            }
        })
    }
    
}
