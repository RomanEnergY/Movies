//
//  BaseView.swift
//  Movies
//
//  Created by Roman Zverik on 16.02.2021.
//  Copyright © 2021 ZRS. All rights reserved.
//

import Foundation
import UIKit

/// Базовый класс вью
class BaseView: UIView {
	
	private(set) var logger: LoggerProtocol
	
	public init(
		frame: CGRect = CGRect.zero,
		logger: LoggerProtocol = DI.container.resolve(LoggerProtocol.self)
	) {
		self.logger = logger
		super.init(frame: frame)
		configure()
		addSubviews()
		makeConstraints()
	}
	
	required public init?(coder aDecoder: NSCoder) {
		DI.container.resolve(LoggerProtocol.self).log(.error, "ERROR")
		fatalError("init(coder:) has not been implemented")
	}
	
	func configure() { }
	
	func addSubviews() { }
	
	func makeConstraints() { }
}
