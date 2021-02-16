//
//  ModuleRouter.swift
//  Movies
//
//  Created by Roman Zverik on 17.09.2020.
//  Copyright © 2020 ZRS. All rights reserved.
//

import UIKit

protocol MainRouterProtocol {
	var navigationController: UINavigationController? { get set }
	var assemblyBuilderProtocol: AssemblyBuilderProtocol? { get set }
}

protocol RouterProtocol: MainRouterProtocol {
	func initialViewController()
	func showeDetail(movie: MainModelMovieProtocol)
	func popToRoot()
}

class Router: RouterProtocol {
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
	
	func showeDetail(movie: MainModelMovieProtocol) {
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
