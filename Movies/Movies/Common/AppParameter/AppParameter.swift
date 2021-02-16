//
//  AppParameter.swift
//  Movies
//
//  Created by Roman Zverik on 16.02.2021.
//  Copyright © 2021 ZRS. All rights reserved.
//

import Foundation

/// Протокол определяющий доступ к пользовательским настройкам приложения
protocol AppParameterProtocol {
	
	/// Дженерик-метод возвращающий настройку пользователя типа T по ключу из 'ApplicationParameterKey'
	/// - Parameters:
	///		- key: ключ для доступа к объекту из перечисления 'ApplicationParameterKey'
	///		- type: тип возвращаемого значения
	/// - Returns: возвращает найденную настройку пользователя типа T
	func get<T>(key: AppParameterKey, type: T.Type) -> T?
	
	/// Метод устнавливающий значение для пользоавательской настройки по ключу из 'ApplicationParameterKey'
	/// - Parameters:
	///		- key: ключ для доступа к объекту из перечисления 'ApplicationParameterKey'
	func set(key: AppParameterKey, value: Any?)
	
	/// Удалить пользовательскую настройку по ключу из перечисления 'ApplicationParameterKey'
	/// - Parameters:
	///		- key: ключ для доступа к объекту из перечисления 'ApplicationParameterKey'
	func remove(key: AppParameterKey)
	
	///Удалить все данные из пользовательского хранилища
	func clear()
}

final class AppParameter: AppParameterProtocol {
	
	private let userDefaults = UserDefaults.standard
	
	func get<T>(key: AppParameterKey, type: T.Type) -> T? {
		userDefaults.object(forKey: key.rawValue) as? T
	}
	
	func set(key: AppParameterKey, value: Any?) {
		userDefaults.set(value, forKey: key.rawValue)
	}
	
	func remove(key: AppParameterKey) {
		userDefaults.removeObject(forKey: key.rawValue)
	}
	
	func clear() {
		AppParameterKey.allCases.forEach { key in
			userDefaults.removeObject(forKey: key.rawValue)
		}
	}
}
