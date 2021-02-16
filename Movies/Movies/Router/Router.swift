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
	
	func go(module: ModuleBuilder, mode: RouterPresentationMode)
	
	func popToRoot()
}

protocol LoggerProtocol {
	func log(_ text: String)
}

struct LoggerConsole: LoggerProtocol {
	func log(_ text: String) {
		print(text)
	}
}

class Router: RouterProtocol {
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
	
	
	func go(module: ModuleBuilder, mode: RouterPresentationMode) {
		let controller = module.build()
		
		switch mode {
			case .modal(let animated):
				guard let sourceController = navigationController.viewControllers.last else {
					logger.log("\(#fileID): \(#function) - navigationController.viewControllers.last == nil")
					return
				}
				
				sourceController.present(controller, animated: animated)
				
			case .modalWithNavigation(let animated):
				break
			case .push(let animated):
				break
			case let .replaceController(with, animated):
				break
			case .replaceAll(let animated):
				break
		}
	}
	
	func popToRoot() {
		navigationController.popToRootViewController(animated: true)
	}
}
