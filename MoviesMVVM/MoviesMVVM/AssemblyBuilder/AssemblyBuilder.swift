//
//  ModuleBuilder.swift
//  MoviesMVVM
//
//  Created by 1234 on 17.09.2020.
//  Copyright © 2020 ZRS. All rights reserved.
//

import UIKit

protocol AssemblyBuilderProtocol {
    func createModuleMain(router: RouterProtocol) -> UIViewController
    func createModuleDescription(router: RouterProtocol, movie: MainMovieProtocol) -> UIViewController
}

enum AssemblyBuilderConst {
    static let descriptionView = "DescriptionViewController"
}

class AssemblyBuilder: AssemblyBuilderProtocol {
    func createModuleMain(router: RouterProtocol) -> UIViewController {
        let viewModel = MainViewModel(router: router)
        let view = MainView()
        view.viewModel = viewModel
        
        return view
    }
    
    func createModuleDescription(router: RouterProtocol, movie: MainMovieProtocol) -> UIViewController {
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: AssemblyBuilderConst.descriptionView) as? DescriptionView {
            
            let viewModel = DescriptionViewModel(router: router, movie: movie)
            vc.viewModel = viewModel
            
            return vc
        }
        
        return UIViewController()
    }
}
