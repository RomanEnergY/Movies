//
//  LoggerConsole.swift
//  Movies
//
//  Created by Roman Zverik on 18.02.2021.
//  Copyright © 2021 ZRS. All rights reserved.
//

import Foundation

class LoggerConsole: LoggerProtocol {
	var logLevels: [LogLevel]
	var contextLevels: [ContextLevel]
	
	init(
		logLevels: [LogLevel] = LogLevel.allCases,
		contextLevels: [ContextLevel] = ContextLevel.allCases
	) {
		self.logLevels = logLevels
		self.contextLevels = contextLevels
	}
	
	func set(logLevels: [LogLevel]) {
		self.logLevels = logLevels
	}
	
	func set(contextLevels: [ContextLevel]) {
		self.contextLevels = contextLevels
	}
	
	func log(_ level: LogLevel, _ message: Any, context: String?, file: String, line: Int, function: String) {
		guard logLevels.contains(level) else { return }
		var textLog = ""
		contextLevels.forEach { contextLevel in
			switch contextLevel {
				case .logLevel:
					textLog += "\(level.rawValue): "
				case .message:
					textLog += "\(message) "
				case .context:
					textLog += "\(context != nil ? "\(context!) ": "")"
				case .fileAndLine:
					textLog += "\(file):\(line) "
				case.function:
					textLog += "\(function) "
			}
		}
		
		print("\(textLog)")
	}
}
