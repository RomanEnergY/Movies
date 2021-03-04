//
//  DevMenuInteractor.swift
//  Movies
//
//  Created by Roman Zverik on 04.03.2021.
//  Copyright © 2021 ZRS. All rights reserved.
//

import Foundation

protocol DevMenuBusinessLogic {
	
}

final class DevMenuInteractor: DevMenuBusinessLogic {
	
	private let presenter: DevMenuPresentationLogic
	
	init(
		presenter: DevMenuPresentationLogic
	) {
		self.presenter = presenter
	}
	
}
