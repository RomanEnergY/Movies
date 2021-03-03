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
	func popToRoot()
}

final class AppNavigator: AppNavigatorProtocol {
	private var window: UIWindow?
	public var currentController: BaseViewController?
	let logger: LoggerProtocol

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
				logger.log(.info, ".modal(animated:\(animated))")
				
			case .modalWithNavigation(let animated):
				logger.log(.info, ".modalWithNavigation(animated:\(animated))")
				break
				
			case .replaceAll(let animated):
				guard let navigationController = window?.rootViewController as? BaseNavigationController else {
					logger.log(.error, "\(#fileID): \(#function) - error not BaseNavigationController")
					return
				}
				
				navigationController.setViewControllers([controller], animated: animated)
				
			case let .replaceLastVC(with, animated):
				logger.log(.info, ".replaceController(with:\(with?.description ?? "nil"), animated:\(animated))")
		}
	}
	
	func popToRoot() {
		logger.log(.info, "popToRoot")
	}
}
