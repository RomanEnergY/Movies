//
//  AppNavigator.swift
//  Movies
//
//  Created by Roman Zverik on 22.02.2021.
//  Copyright © 2021 ZRS. All rights reserved.
//

import UIKit

protocol AppNavigatorProtocol {
	func create(_ window: UIWindow?)
	func go(module: ModuleBuilder, mode: PresentationMode)
	func setCurrentController(view: BaseViewController)
	func modalNavigationControllerClose()
}

final class AppNavigator: AppNavigatorProtocol {
	
	private let logger: LoggerProtocol
	private var window: UIWindow?
	private var modalRootViewController: BaseViewController?
	private var modalNavigationController: BaseNavigationController?
	private weak var currentController: BaseViewController?
	
	init(
		logger: LoggerProtocol = DI.container.resolve(LoggerProtocol.self)
	) {
		self.logger = logger
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
	
	func go(module: ModuleBuilder, mode: PresentationMode) {
		let controller = module.build()
		
		switch mode {
			case .push(let animated):
				var navigationController: BaseNavigationController? = nil
				
				if let modalNavigationController = modalNavigationController {
					navigationController = modalNavigationController
				}
				else if let rootNavigationController = window?.rootViewController as? BaseNavigationController {
					navigationController = rootNavigationController
				}
				
				guard let navController = navigationController else {
					logger.log(.error, "this not navigationController")
					return
				}
				
				currentController = controller
				navController.pushViewController(controller, animated: animated)
				
			case .modal(let animated):
				logger.log(.error, "no impl - .modal(animated:\(animated)) - \(controller)")
				
			case .modalWithNavigation(let animated):
				
				if modalNavigationController != nil {
					logger.log(.error, "repetition modalNavigationController forbidden")
						return
				}
				
				modalNavigationController = BaseNavigationController(rootViewController: controller)
				currentController?.present(modalNavigationController!, animated: animated)
				
			case .replaceAll(let animated):
				guard let navigationController = window?.rootViewController as? BaseNavigationController else {
					logger.log(.error, "this not rootNavigationController")
					return
				}
				
				currentController = controller
				navigationController.setViewControllers([controller], animated: animated)
				
			case let .replaceLastVC(with, animated):
				logger.log(.error, "no impl - .replaceLastVC(with:\(with?.description ?? "nil"), animated:\(animated))")
		}
	}
	
	func setCurrentController(view: BaseViewController) {
		currentController = view
	}
	
	func modalNavigationControllerClose() {
		modalNavigationController = nil
	}
}
