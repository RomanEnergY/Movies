//
//  BeginningData.swift
//  Movies
//
//  Created by Roman Zverik on 21.02.2021.
//  Copyright © 2021 ZRS. All rights reserved.
//

import UIKit

protocol BeginningDataProtocol {
	var title: String { get }
	var paragraphs: [TitleParagraphModel] { get }
}

struct BeginningData: BeginningDataProtocol {
	var title: String {
		 return "👋🤩 Привет!! 😉🤗"
	}
	
	var paragraphs: [TitleParagraphModel] {
		var paragraphs = [TitleParagraphModel]()
		paragraphs.append(
			TitleParagraphModel(title: "\tЭто тестовое приложение - так сказать обзор/проработка методик работы на чистом Swift - и вот получилось приложение \"ФИЛЬМЫ\" 🥳"))
		paragraphs.append(
			TitleParagraphModel(title: "\tНе судите строго - я не дизайнер 😅, а разработчик 🤯, но если будет поставлен четкий дизайн - поправим по Figma или Zeplin 😉"))
		paragraphs.append(
			TitleParagraphModel(title: "\tПри разработке использовался стек, фишки и примочки:", paragraph: ["XCode 12", "Swift 5+", "iOS 14.1", "Automatic Reference Count", "Grand Center Dispatch", "UIKit", "Digital integration (DI)", "Logger", "Property Wrapper", "UserDefaults", "SOLID", "YARCH", "CocoaPods", "SnapKit", "Unit test", "SmartGit", "ColorSlurp", "Sublime Text", "Pastman", "NinjaMock", "Figma"]))
		paragraphs.append(
			TitleParagraphModel(title: "\tВ данном проекте использовал следующие паттерны проектирования:", paragraph: ["Factory method", "Builder", "Singelton", "Adapter", "Bridge", "Delegate", "Decorator", "Facade", "Proxy", "Observer"]))
		paragraphs.append(
			TitleParagraphModel(title: "\tПриложение находится на стадии: \"In development 🤯\" и каждый день оно улучшается и меняется в лучшую сторону - и это круто!!! 😇"))
		paragraphs.append(
			TitleParagraphModel(title: "Zverik Roman\nг.Санкт-Петербург\nтел: +7-951-651-25-99\nemail: Zverik.r.s@gmail.com"))
		
		return paragraphs
	}
}
