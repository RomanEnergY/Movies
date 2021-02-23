//
//  ModuleRouter.swift
//  Movies
//
//  Created by Roman Zverik on 17.09.2020.
//  Copyright © 2020 ZRS. All rights reserved.
//

import UIKit

protocol RouterProtocol {
	func initialViewController()
	func showDetailViewMovie(movie: MainModelMovieProtocol)
}

class Router: RouterProtocol {
	private var window: UIWindow?
	public var currentController: BaseViewController?
	let logger: LoggerProtocol
	
	let navigationController: BaseNavigationController
	let assemblyBuilderProtocol: AssemblyBuilderProtocol?
	
	init(logger: LoggerProtocol = DI.container.resolve(LoggerProtocol.self),
		 navigationController: BaseNavigationController = DI.container.resolve(BaseNavigationController.self),
		 assemblyBuilderProtocol: AssemblyBuilderProtocol = DI.container.resolve(AssemblyBuilderProtocol.self)
	) {
		self.logger = logger
		self.navigationController = navigationController
		self.assemblyBuilderProtocol = assemblyBuilderProtocol
	}
	
	func initialViewController() {
		guard let mainViewController = assemblyBuilderProtocol?.createModuleMain(router: self)
		else { return }
		
		navigationController.viewControllers = [mainViewController]
	}
	
	func showDetailViewMovie(movie: MainModelMovieProtocol) {
		guard let detailViewController = assemblyBuilderProtocol?.createModuleDescription(router: self, movie: movie)
		else { return }
		
		navigationController.pushViewController(detailViewController, animated: true)
	}
}
