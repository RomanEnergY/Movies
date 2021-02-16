//
//  RouterDismissionMode.swift
//  Movies
//
//  Created by Roman Zverik on 16.02.2021.
//  Copyright © 2020 ZRS. All rights reserved.
//

import Foundation

public enum RouterDismissMode {
	
	/// Закрытие, при котором текущий модальный контроллер будет закрыт. (Вместе с навигационным стеком)
	///
	/// - animated: Индикатор, показывающий должен ли быть переход анимированным
	case dismiss(animated: Bool)
	
	/// Закрытие, при котором будет осуществлен переход назад по стеку навигационного контроллера
	///
	/// - animated: Индикатор, показывающий должен ли быть переход анимированным
	case pop(animated: Bool)
	
	/// Закрытие, при котором будет осуществлен переход назад по стеку навигационного контроллера к самому первому
	///
	/// - animated: Индикатор, показывающий должен ли быть переход анимированным
	case popToRoot(animated: Bool)
}
