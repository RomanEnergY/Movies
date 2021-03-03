//
//  AppParameterStorage.swift
//  Movies
//
//  Created by Roman Zverik on 17.02.2021.
//  Copyright © 2021 ZRS. All rights reserved.
//

import Foundation

protocol AppParameterStorageProtocol {
	associatedtype T
	var key: AppParameterKey { get }
	var wrappedValue: T? { get set }
}

@propertyWrapper
struct AppParameterStorage<T>: AppParameterStorageProtocol {
	
	// MARK: - public variables
	
	var key: AppParameterKey
	var wrappedValue: T? {
		get {
			appParameter.get(key: key, type: T.self)
		}
		
		set {
			appParameter.set(key: key, value: newValue)
		}
	}
	
	// MARK: - private variables
	
	private let appParameter: AppUserSettingsProtocol
	
	// MARK: - init
	
	init(
		key: AppParameterKey,
		appParameter: AppUserSettingsProtocol = DI.container.resolve(AppUserSettingsProtocol.self)
	) {
		self.key = key
		self.appParameter = appParameter
	}
}
