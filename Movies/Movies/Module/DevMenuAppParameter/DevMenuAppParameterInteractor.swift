//
//  DevMenuAppParameterInteractor.swift
//  Movies
//
//  Created by Roman Zverik on 08.03.2021.
//  Copyright © 2021 ZRS. All rights reserved.
//

import Foundation

protocol DevMenuAppParameterBusinessLogic {
	func initial()
}

final class DevMenuAppParameterInteractor: DevMenuAppParameterBusinessLogic {
	
	// MARK: - private variables
	
	private let presenter: DevMenuAppParameterPresentationLogic
	private let appParameter: AppParameterProtocol
	private let appParameterKeys: [AppParameterKey]
	
	// MARK: - Initializer
	
	init(
		presenter: DevMenuAppParameterPresentationLogic,
		appParameter: AppParameterProtocol = DI.container.resolve(AppParameterProtocol.self)
	) {
		self.presenter = presenter
		self.appParameter = appParameter
		self.appParameterKeys = AppParameterKey.allCases
	}
	
	func initial() {
		
	}
}
