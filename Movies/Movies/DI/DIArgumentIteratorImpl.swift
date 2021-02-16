//
//  DIArgumentIterator.swift
//  Movies
//
//  Created by Roman Zverik on 16.02.2021.
//  Copyright © 2021 ZRS. All rights reserved.
//

import Foundation

/// Протокол, определяющий итератора для аргументов DI
public protocol DIArgumentIteratorProtocol {
	/// Массив всех аргументов, read-only
	var all: [Any] { get }
	/// Первый аргумент
	/// - Parameters:
	/// 	- type: тип аргумента
	/// -  Returns: аргумент
	func first<T>(type: T.Type) -> T
	/// Второй аргумент
	/// - Parameters:
	/// 	- type: тип аргумента
	/// -  Returns: аргумент
	func second<T>(type: T.Type) -> T
	/// Третий аргумент
	/// - Parameters:
	/// 	- type: тип аргумента
	/// -  Returns: аргумент
	func third<T>(type: T.Type) -> T
	/// Получение аргумента по индексу
	/// - Parameters:
	///  	- index: индекс элемента
	/// 	- type: тип аргумента
	/// -  Returns: аргумент, может быть nil, если аргумента по заданным параметрам не существует
	func arg<T>(_ index: Int, type: T.Type) -> T?
	/// Получение аргумента по индексу
	/// - Throws: FatalError, если аргумента по заданным параметрам не существует
	/// - Parameters:
	///  	- index: индекс элемента
	/// 	- type: тип аргумента
	/// -  Returns: аргумент
	func arg<T>(_ index: Int, type: T.Type) -> T
}

/// Реализация DIArgumentIterator протокола
struct DIArgumentIterator: DIArgumentIteratorProtocol {
	var all: [Any]

	func first<T>(type: T.Type) -> T {
		return arg(0, type: type)
	}

	func second<T>(type: T.Type) -> T {
		return arg(1, type: type)
	}

	func third<T>(type: T.Type) -> T {
		return arg(2, type: type)
	}

	func arg<T>(_ index: Int, type: T.Type) -> T {
		guard let res = arg(index, type: type) else {
			fatalError("Argument with index \(index) is no availiable")
		}
		return res
	}

	func arg<T>(_ index: Int, type: T.Type) -> T? {
		if let any = all[safe: index], let res = any as? T {
			return res
		}
		return nil
	}
}
