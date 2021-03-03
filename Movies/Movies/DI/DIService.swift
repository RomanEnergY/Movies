//
//  DIService.swift
//  Movies
//
//  Created by Roman Zverik on 16.02.2021.
//  Copyright © 2021 ZRS. All rights reserved.
//

import Foundation

protocol DIServiceProtocol {
	func resolve<T>(type: T.Type, in container: DIContainerProtocol, args: [Any]) -> T?
}

class DIService: DIServiceProtocol {
	private var isSingleton: Bool
	private var isFactoryPerformed: Bool = false
	private var singletone: Any?
	private var factory: (_ resolver: DIContainerProtocol, _ args: DIArgumentIterator) -> Any?

	/// Получить экземляр объекта типа T
	/// - Parameters:
	///		- type: тип инстанцируемого объекта
	/// - Returns: возвращает инстанс объекта типа T
	func resolve<T>(type: T.Type, in container: DIContainerProtocol, args: [Any] = []) -> T? {
		let argIterator = DIArgumentIterator(all: args)
		if isSingleton {
			if !isFactoryPerformed {
				singletone = factory(container, argIterator)
				isFactoryPerformed = true
			}
			return singletone as? T
		}
		else {
			return factory(container, argIterator) as? T
		}
	}

	init(singleton: Bool = false, factory: @escaping (_ resolver: DIContainerProtocol, _ args: DIArgumentIterator) -> Any?) {
		self.isSingleton = singleton
		self.factory = factory
	}
}
