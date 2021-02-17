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
	
	func create(_ window: UIWindow?)
	func popToRoot()
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
	
	
	func go(module: ModuleBuilder, mode: RouterPresentationMode) {
		let controller = module.build()
		
		switch mode {
			case .modal(let animated):
				guard let sourceController = navigationController.viewControllers.last else {
					logger.log(.error, "\(#fileID): \(#function) - navigationController.viewControllers.last == nil")
					return
				}
				
				sourceController.present(controller, animated: animated)
				
			case .modalWithNavigation(let animated):
				break
				
			case .push(let animated):
				guard let navigationController = window?.rootViewController as? BaseNavigationController else {
					logger.log(.error, "\(#fileID): \(#function) - error not BaseNavigationController")
					return
				}
				
				currentController = controller
				navigationController.pushViewController(controller, animated: animated)
				
			case let .replaceController(with, animated):
				break
			case .replaceAll(let animated):
				break
		}
	}
	
	/// Создает инстанс главного окна приложения и инициализирует первичный экран связанный с переданным 'BaseViewController'
	/// - Parameters:
	///		- app: инстанс хрянящий экземпляр главного окна приложения. В данной роли выступает AppDelegate
	public func create(_ window: UIWindow?) {
		self.window = window
		self.window?.backgroundColor = UIColor.white
		
		let rootViewController = BeginningBuilder().build()
		self.window?.rootViewController = BaseNavigationController(rootViewController: rootViewController)
		currentController = rootViewController
		
		self.window?.makeKeyAndVisible()
	}
	
	func popToRoot() {
		navigationController.popToRootViewController(animated: true)
	}
}
