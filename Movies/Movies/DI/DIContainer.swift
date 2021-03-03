//
//  DIContainer.swift
//  Movies
//
//  Created by Roman Zverik on 16.02.2021.
//  Copyright © 2021 ZRS. All rights reserved.
//

import Foundation

/// Протокол экземпляра DI Core
public protocol DIProtocol {
	static var container: DIContainerProtocol { get }
}

/// Протокол контейнера DI
public protocol DIContainerProtocol {

	///  Регистрация экземпляра в DI
	/// - Parameters:
	///   - type: Регистрируемый тип
	///   - factory: Замыкание в котором создается объект
	func register<T>(_ type: T.Type, factory: @escaping (_ resolver: DIContainerProtocol) -> T)

	/// Регистрация экземпляра в DI
	/// - Parameters:
	///   - type: Регистрируемый тип
	///   - factory: Замыкание в котором создается объект
	func register<T>(_ type: T.Type, factory: @escaping (_ resolver: DIContainerProtocol, _ args: DIArgumentIteratorProtocol) -> T)

	///  Регистрация единственного экземпляра
	/// - Parameters:
	///   - type: Регистрируемый тип
	///   - factory: Замыкание в котором создается объект
	func registerSingle<T>(_ type: T.Type, factory: @escaping (_ resolver: DIContainerProtocol) -> T)

	///  Регистрация единственного экземпляра
	/// - Parameters:
	///   - type: Регистрируемый тип
	///   - factory: Замыкание в котором создается объект
	func registerSingle<T>(_ type: T.Type, factory: @escaping (_ resolver: DIContainerProtocol, _ args: DIArgumentIteratorProtocol) -> T)

	/// Получить экземпляр класса по типу (не будет ошибки, если объект не зарегистрирован)
	/// - Parameters:
	///   - type: тип, который необходимо получить
	func resolveSafe<T>(_ type: T.Type) -> T?

	/// Получить экземпляр класса по типу (не будет ошибки, если объект не зарегистрирован)
	/// - Parameters:
	///   - type: ип, который необходимо получить
	///   - args: дополнительные параметры
	func resolveSafe<T>(_ type: T.Type, args: Any...) -> T?

	/// Получить экземпляр класса по типу
	/// - Parameters:
	///   - type: тип, который необходимо получить
	func resolve<T>(_ type: T.Type) -> T

	/// Получить экземпляр класса по типу
	/// - Parameters:
	///   - type: тип, который необходимо получить
	///   - args: дополнительные параметры
	func resolve<T>(_ type: T.Type, args: Any...) -> T

	/// Удалить зарегистрированный тип
	/// - Parameter type: Тип регистрацию которого ужно отменить
	func unregister<T>(_ type: T.Type)
}


/// Реализация DI - контейнера
class DIContainer: DIContainerProtocol {

	// MARK: - Variables
	private var services: [AnyHashable: DIServiceProtocol] = [:]

	public init() {}

	// MARK: - Methods

	public func register<T>(_ type: T.Type, factory: @escaping (_ resolver: DIContainerProtocol) -> T) {
		let wrapper: (DIContainerProtocol, DIArgumentIteratorProtocol) -> Any? = { resolver, _ in
			return factory(resolver)
		}
		register(type, single: false, factory: wrapper)
	}

	func register<T>(_ type: T.Type, factory: @escaping (DIContainerProtocol, DIArgumentIteratorProtocol) -> T) {
		register(type, single: false, factory: factory)
	}

	public  func registerSingle<T>(_ type: T.Type, factory: @escaping (_ resolver: DIContainerProtocol) -> T) {
		let wrapper: (DIContainerProtocol, DIArgumentIteratorProtocol) -> Any = { resolver, _ in
			return factory(resolver)
		}
		register(type, single: true, factory: wrapper)
	}

	func registerSingle<T>(_ type: T.Type, factory: @escaping (DIContainerProtocol, DIArgumentIteratorProtocol) -> T) {
		register(type, single: true, factory: factory)
	}

	public func resolve<T>(_ type: T.Type) -> T {
		return resolve(type, optional: false)!
	}

	func resolve<T>(_ type: T.Type, args: Any...) -> T {
		return resolve(type, optional: false, args: args)!
	}

	func resolveSafe<T>(_ type: T.Type) -> T? {
		return resolve(type, optional: true)
	}

	func resolveSafe<T>(_ type: T.Type, args: Any...) -> T? {
		return resolve(type, optional: true, args: args)
	}

	public func resolve<T>(_ type: T.Type, optional: Bool, args: [Any] = []) -> T? {
		let key = makeKey(type: type)
		guard let service = services[key] else {
			if optional {
				return nil
			}
			fatalError("\(key) not registered in DI")
		}
		return service.resolve(type: type, in: self, args: args)
	}

	public func unregister<T>(_ type: T.Type) {
		let key = makeKey(type: type)
		services.removeValue(forKey: key)
	}
	
	// MARK: - Private
	func register<T>(_ type: T.Type, single: Bool, factory: @escaping (DIContainerProtocol, DIArgumentIteratorProtocol) -> Any?) {
		let service = DIService(singleton: single, factory: factory)
		let key = makeKey(type: type)
		services[key] = service
	}

	private func makeKey<T>(type: T.Type) -> String {
		return String(describing: type)
	}

}
