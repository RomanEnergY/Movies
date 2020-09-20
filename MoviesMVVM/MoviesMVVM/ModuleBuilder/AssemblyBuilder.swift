//
//  ModuleBuilder.swift
//  MoviesMVVM
//
//  Created by 1234 on 17.09.2020.
//  Copyright © 2020 ZRS. All rights reserved.
//

import UIKit

protocol AssemblyBuilderProtocol {
    func createModuleMain(router: ModuleRouterProtocol) -> UIViewController
    func createModuleDescription(router: ModuleRouterProtocol, movie: MainMovieProtocol) -> UIViewController
}

class AssemblyBuilder: AssemblyBuilderProtocol {
    func createModuleMain(router: ModuleRouterProtocol) -> UIViewController {
        let viewModel = MainViewModel(router: router)
        let view = MainView()
        view.viewModel = viewModel
        
        return view
    }
    
    func createModuleDescription(router: ModuleRouterProtocol, movie: MainMovieProtocol) -> UIViewController {
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "DescriptionViewController") as? DescriptionView {
            
            let viewModel = DescriptionViewModel(router: router, movie: movie)
            vc.viewModel = viewModel
            
            return vc
        }
        
        return UIViewController()
    }
}
