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
}

final class AppNavigator: AppNavigatorProtocol {
	
	private let logger: LoggerProtocol
	private var window: UIWindow?
	private var modalRootViewController: BaseViewController?
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
				guard let navigationController = window?.rootViewController as? BaseNavigationController else {
					logger.log(.error, "\(#fileID): \(#function) - error not BaseNavigationController")
					return
				}
				
				currentController = controller
				navigationController.pushViewController(controller, animated: animated)
				
			case .modal(let animated):
				logger.log(.error, "no impl - .modal(animated:\(animated))")
				
			case .modalWithNavigation(let animated):
				
				let navigationController = BaseNavigationController(rootViewController: controller)
				currentController?.present(navigationController, animated: animated)
				
			case .replaceAll(let animated):
				guard let navigationController = window?.rootViewController as? BaseNavigationController else {
					logger.log(.error, "\(#fileID): \(#function) - error not BaseNavigationController")
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
}
