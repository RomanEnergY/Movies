//
//  BaseViewController.swift
//  Movies
//
//  Created by Roman Zverik on 16.02.2021.
//  Copyright © 2021 ZRS. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
	
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
}
