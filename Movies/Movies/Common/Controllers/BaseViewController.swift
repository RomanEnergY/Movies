//
//  BaseViewController.swift
//  Movies
//
//  Created by Roman Zverik on 16.02.2021.
//  Copyright © 2021 ZRS. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
	
	/// Свойство контролирующее видимость навигейшн бара, если true навигейшн бар будет скрыт
	var isHiddenNavigationBar = false
	
	// MARK: - private variable
	
	let logger: LoggerProtocol
	let appNavigator: AppNavigatorProtocol
	
	init(
		logger: LoggerProtocol = DI.container.resolve(LoggerProtocol.self),
		appNavigator: AppNavigatorProtocol = DI.container.resolve(AppNavigatorProtocol.self)
	) {
		self.logger = logger
		self.appNavigator = appNavigator
		super.init(nibName: nil, bundle: nil)
		logger.log(.debug, "init: \(self)")
	}
	
	required public init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	deinit {
		logger.log(.error, "deinit: \(self)")
	}
	
	override open func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		navigationController?.setNavigationBarHidden(isHiddenNavigationBar, animated: true)
		logger.log(.debug, "viewWillAppear: \(self)")
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		logger.log(.debug, "viewDidAppear: \(self)")
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		logger.log(.debug, "viewWillDisappear: \(self)")
	}
	
	override func viewDidDisappear(_ animated: Bool) {
		logger.log(.debug, "viewDidDisappear: \(self)")
	}
}
