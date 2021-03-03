//
//  AppParameterKey.swift
//  Movies
//
//  Created by Roman Zverik on 16.02.2021.
//  Copyright © 2021 ZRS. All rights reserved.
//

import Foundation

enum AppParameterKey: String, CaseIterable {
	/// Был ли ранее показан стартовый экран "BeginningView"
	/// - Bool
	case isBeginningViewShowedOnce
	
	/// Был ли ранее установлен пароль "passwordNumderKey"
	/// - Bool
	case isPasswordNumberKeyInstalled
	
	/// Значение поля "passwordNumderKey"
	/// - String
	case passwordNumberKey
}
