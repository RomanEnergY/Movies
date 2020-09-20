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
    func createModuleDescription(router: ModuleRouterProtocol, name: String?) -> UIViewController
}

class AssemblyBuilder: AssemblyBuilderProtocol {
    func createModuleMain(router: ModuleRouterProtocol) -> UIViewController {
        let viewModel = MainViewModel()
        let view = MainView()
        view.viewModel = viewModel
        
        return view
    }
    
    func createModuleDescription(router: ModuleRouterProtocol, name: String?) -> UIViewController {
//        let view = DetailViewController()
//        let presenter = DetailPresenter(view: view, router: router, name: name)
//
//        view.presenter = presenter
//        return view
        
        return UIViewController()
    }
}
