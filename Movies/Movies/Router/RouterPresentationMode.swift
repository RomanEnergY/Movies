//
//  RouterPresentationMode.swift
//  Movies
//
//  Created by Roman Zverik on 16.02.2021.
//  Copyright © 2020 ZRS. All rights reserved.
//

import Foundation

/// Перечисление режимов роутера
public enum RouterPresentationMode {
	
	///Стандартный *push* переход с анимацией по умолчанию
	///
	/// - animated: Индикатор, показывающий должен ли быть переход анимированным
	case push(animated: Bool)
	
	///Модальный переход с экрана на экран
	///
	/// - animated: Индикатор, показывающий должен ли быть переход анимированным
	case modal(animated: Bool)
	
	///Модальный переход с экрана на экран с NavigationController
	///
	/// - animated: Индикатор, показывающий должен ли быть переход анимированным
	case modalWithNavigation(animated: Bool)
	
	///Переход, заменяющий все контроллеры из текущей иерархии под NavigationController на передаваемый
	///
	/// - animated: Индикатор, показывающий должен ли быть переход анимированным
	case replaceAll(animated: Bool)
	
	///Переход, заменяющий только текущий контроллер из текущей иерархии под NavigationController на передаваемый
	case replaceController(with: BaseViewController?, animated: Bool)
}
