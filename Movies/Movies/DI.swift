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
						  contextLevels: [.logLevel, .message, .context, .fileAndLine])
		}
		container.registerSingle(AppUserSettingsProtocol.self) { _ in AppUserDefaultsStorage() }
		container.registerSingle(AppParameterProtocol.self) { _ in AppParameter() }
		container.registerSingle(AssemblyBuilderProtocol.self) { _ in AssemblyBuilder() }
		
		//TODO заменить Router на AppNavigator
//		container.registerSingle(RouterProtocol.self) { _ in Router() }
		container.registerSingle(AppNavigatorProtocol.self) { _ in AppNavigator() }
		
		container.registerSingle(BaseNavigationController.self) { _ in BaseNavigationController() }
		
		container.register(PasswordKeyProviderProtocol.self) { _ in PasswordKeyProvider() }
		container.register(MovieDataServiceProtocol.self) { _ in MovieDataService() }
		container.register(MovieImageServiceProtocol.self) { _ in MovieImageService() }
		container.register(MovieDesctiptionServiceProtocol.self) { _ in MovieDesctiptionService() }
	}
}
