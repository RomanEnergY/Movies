//
//  AppParameter.swift
//  Movies
//
//  Created by Roman Zverik on 16.02.2021.
//  Copyright © 2021 ZRS. All rights reserved.
//

import Foundation

protocol AppParameterProtocol: class {
	var count: Int { get }
	var isBeginningViewShowedOnce: Bool? { get set }
	var isPasswordNumberKeyInstalled: Bool? { get set }
	var passwordNumberKey: String? { get set }
}

class AppParameter: AppParameterProtocol {
	
	var count: Int {
		AppParameterKey.AllCases().count
	}
	
	@AppParameterStorage<Bool>(key: .isBeginningViewShowedOnce)
	var isBeginningViewShowedOnce
	
	@AppParameterStorage<Bool>(key: .isPasswordNumberKeyInstalled)
	var isPasswordNumberKeyInstalled
	
	@AppParameterStorage<String>(key: .passwordNumberKey)
	var passwordNumberKey
}
