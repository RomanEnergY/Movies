//
//  Date+Extention.swift
//  Movies
//
//  Created by Roman Zverik on 03.03.2021.
//  Copyright © 2021 ZRS. All rights reserved.
//

import Foundation

extension Date {
	func formatter(dateFormat: String) -> String {
		let dateFormatter = DateFormatter()
		dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
		dateFormatter.locale = Locale(identifier: "ru_RU")
		dateFormatter.dateFormat = dateFormat
		
		return dateFormatter.string(from: self)
	}
}
