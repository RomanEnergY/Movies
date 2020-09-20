//
//  Router.swift
//  MoviesMVVM
//
//  Created by 1234 on 17.09.2020.
//  Copyright © 2020 ZRS. All rights reserved.
//

import UIKit

protocol ModuleMainRouterProtocol {
    var navigationController: UINavigationController? { get set }
    var assemblyBuilderProtocol: AssemblyBuilderProtocol? { get set }
}

protocol ModuleRouterProtocol: ModuleMainRouterProtocol {
    func initialViewController()
    func showeDetail(movie: MainMovieProtocol)
    func popToRoot()
}

class ModuleRouter: ModuleRouterProtocol {
    var navigationController: UINavigationController?
    var assemblyBuilderProtocol: AssemblyBuilderProtocol?
    
    init(navigationController: UINavigationController? = nil, assemblyBuilderProtocol: AssemblyBuilderProtocol? = nil) {
        self.navigationController = navigationController
        self.assemblyBuilderProtocol = assemblyBuilderProtocol
    }
    
    func initialViewController() {
        guard let navigationController = navigationController,
            let mainViewController = assemblyBuilderProtocol?.createModuleMain(router: self)
            else { return }
        
        navigationController.viewControllers = [mainViewController]
    }
    
    func showeDetail(movie: MainMovieProtocol) {
        guard let navigationController = navigationController,
              let detailViewController = assemblyBuilderProtocol?.createModuleDescription(router: self, movie: movie)
            else { return }
        
        navigationController.pushViewController(detailViewController, animated: true)
    }
    
    func popToRoot() {
        guard let navigationController = navigationController
            else { return }
        
        navigationController.popToRootViewController(animated: true)
    }
}
