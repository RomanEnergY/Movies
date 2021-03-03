//
//  PresentationMode.swift
//  Movies
//
//  Created by Roman Zverik on 22.02.2021.
//  Copyright © 2021 ZRS. All rights reserved.
//

import Foundation

enum PresentationMode {
	
	///Стандартный *push* переход с анимацией по умолчанию
	case push(animated: Bool)
	
	///Модальный переход с экрана на экран
	case modal(animated: Bool)
	
	///Модальный переход с экрана на экран с NavigationController
	case modalWithNavigation(animated: Bool)
	
	///Переход, заменяющий все контроллеры из текущей иерархии под NavigationController на передаваемый
	case replaceAll(animated: Bool)
	
	///Переход, заменяющий только текущий контроллер из текущей иерархии под NavigationController на передаваемый
	case replaceLastVC(with: BaseViewController?, animated: Bool)
}
