//
//  LoggerProtocol.swift
//  Movies
//
//  Created by Roman Zverik on 17.02.2021.
//  Copyright © 2021 ZRS. All rights reserved.
//

import Foundation

/// Уровни логгирования
enum LogLevel: String, CaseIterable {
	case info = "🟦"
	case debug = "🟩"
	case warning = "🟨"
	case error = "🟥"
	case request = "📡"
	case requestStub = "💾"
}

/// Уровни логгирования
enum ContextLevel: String, CaseIterable {
	case logLevel
	case message
	case context
	case fileAndLine
	case function
}

protocol LoggerProtocol: class {
	/// Политика фильтрации логов по уровню, read-only
	var logLevels: [LogLevel] { get }
	var contextLevels: [ContextLevel] { get }
	
	/// Установка политики фильтрации логов
	/// - Parameters:
	/// 	- filter: Уровень фильтрации по уровню логгирования
	func set(logLevels: [LogLevel])
	
	/// Установка политики фильтрации логов
	/// - Parameters:
	/// 	- filter: Уровень фильтрации по контексту
	func set(contextLevels: [ContextLevel])
	
	/// Метод, осуществляющий запись логгируемого сообщения
	/// - Parameters:
	/// 	- level: уровень логгирования
	/// 	- message: сообщение
	/// 	- context: контекст сообщения
	/// 	- file: файл, откуда поступает сообщение
	/// 	- line: номер строки
	/// 	- function: функция
	func log(_ level: LogLevel, _ message: Any, context: String?, file: String, line: Int, function: String)
}

extension LoggerProtocol {
	func log(_ level: LogLevel, _ message: Any, context: String? = nil, file: String = #fileID, line: Int = #line, function: String = #function) {
		log(level, message, context: context, file: file, line: line, function: function)
	}
}
