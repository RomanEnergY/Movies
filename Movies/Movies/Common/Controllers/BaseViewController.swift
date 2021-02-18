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
	
	private let logger: LoggerProtocol
	
	init(
		logger: LoggerProtocol = DI.container.resolve(LoggerProtocol.self)
	) {
		self.logger = logger
		super.init(nibName: nil, bundle: nil)
	}
	
	required public init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override open func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		navigationController?.setNavigationBarHidden(isHiddenNavigationBar, animated: true)
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		logger.log(.debug, "viewDidAppear: \(self)")
	}
}
