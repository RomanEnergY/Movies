//
//  TitleParagraphViewModel.swift
//  Movies
//
//  Created by Roman Zverik on 21.02.2021.
//  Copyright © 2021 ZRS. All rights reserved.
//

import UIKit

struct TitleParagraphViewModel<T: WrappreString, Y: WrappreArrayString> {
	let title: FontTypeViewModel<T>
	let paragraph: FontTypeViewModel<Y>
	let textAlignment: NSTextAlignment
	
	init(title: FontTypeViewModel<T>, paragraph: FontTypeViewModel<Y>, textAlignment: NSTextAlignment) {
		self.title = title
		self.paragraph = paragraph
		self.textAlignment = textAlignment
	}
}

struct FontTypeViewModel<T> {
	let data: T
	let font: UIFont
	
	init(data: T, font: UIFont) {
		self.data = data
		self.font = font
	}
}

class WrappreString {
	let text: String
	
	init(text: String) {
		self.text = text
	}
}

class WrappreArrayString {
	let array: [String]
	
	init(array: [String]) {
		self.array = array
	}
}
