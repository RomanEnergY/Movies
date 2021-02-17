//
//  DI.swift
//  Movies
//
//  Created by Roman Zverik on 16.02.2021.
//  Copyright © 2021 ZRS. All rights reserved.
//

import Foundation

typealias DI = ProjectDI

public enum ProjectDI {
	/// DI - контейнер
	public static var container: DIContainerProtocol = DIContainer()

	/// Регистрация Core - сущностей
	public static func configureApp() {
		container.registerSingle(LoggerProtocol.self) { _ in
			LoggerConsole(logLevels: LogLevel.allCases,
						  contextLevels: [.logLevel, .message, .context])
		}
		container.registerSingle(AppUserSettingsProtocol.self) { _ in AppUserDefaultsStorage() }
		container.registerSingle(AppParameterProtocol.self) { _ in AppParameter() }
		container.registerSingle(AssemblyBuilderProtocol.self) { _ in AssemblyBuilder() }
		container.registerSingle(RouterProtocol.self) { _ in Router() }
		container.registerSingle(BaseNavigationController.self) { _ in BaseNavigationController() }
	}
}
