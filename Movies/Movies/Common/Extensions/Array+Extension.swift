//
//  ExtensionArray.swift
//  Movies
//
//  Created by Roman Zverik on 16.02.2021.
//  Copyright © 2021 ZRS. All rights reserved.
//

import Foundation

/// Расширение для Array, определяющее метод с безопасным доступом к элементу массива по индексу
public extension Array {
	/// Метод возвращает значение элемента по индексу массива
	/// - Parameters:
	/// 	- index: индекс элемента массива, который требуется вернуть
	/// - Returns: возвращает элемент массива, если найден, или nil в противном случае
	subscript (safe index: Int) -> Element? {
		return indices ~= index ? self[index] : nil
	}
}
