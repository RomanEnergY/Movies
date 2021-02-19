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
	
	var statusBarHeight: CGFloat = {
		if let statusBar = UIApplication.shared.windows.last?.windowScene?.statusBarManager {
			return statusBar.isStatusBarHidden ? 0 : statusBar.statusBarFrame.height
		}
		else {
			return 0
		}
	}()
	var navigationBarHeight: CGFloat {
		if let navVC = window?.rootViewController as? UINavigationController {
			return navVC.navigationBar.isHidden ? 0 : navVC.navigationBar.frame.height
		}
		else {
			return 0.0
		}
	}
	
	var allBarsHeight: CGFloat {
		return statusBarHeight + navigationBarHeight
	}
	
	private let logger: LoggerProtocol
	
	public init(
		frame: CGRect = CGRect.zero,
		logger: LoggerProtocol = DI.container.resolve(LoggerProtocol.self)
	) {
		self.logger = logger
		super.init(frame: frame)
		configure()
		addSubviews()
	}
	
	required public init?(coder aDecoder: NSCoder) {
		DI.container.resolve(LoggerProtocol.self).log(.error, "ERROR")
		fatalError("init(coder:) has not been implemented")
	}
	
	override func layoutSubviews() {
		makeConstraints()
		super.layoutSubviews()
	}
	
	open func configure() { }
	
	open func addSubviews() { }
	
	open func makeConstraints() { }
}
