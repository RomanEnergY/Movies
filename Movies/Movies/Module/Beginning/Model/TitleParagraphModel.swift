//
//  TitleParagraphModel.swift
//  Movies
//
//  Created by Roman Zverik on 22.02.2021.
//  Copyright © 2021 ZRS. All rights reserved.
//

import Foundation

/// Модель представления заголовка и списка параграфов
/// - Parameter :
///title: String - заголовок параграфа
/// - Parameter :
/// paragraph: [String] - массив параграфов
struct TitleParagraphModel {
	let title: String
	let paragraph: [String]
	
	init(title: String, paragraph: [String] = [String]()) {
		self.title = title
		self.paragraph = paragraph
	}
}
