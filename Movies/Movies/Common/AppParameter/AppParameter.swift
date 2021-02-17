//
//  AppParameter.swift
//  Movies
//
//  Created by Roman Zverik on 16.02.2021.
//  Copyright © 2021 ZRS. All rights reserved.
//

import Foundation

protocol AppParameterProtocol {
	var isBeginningViewShowedOnce: Bool? { get set }
}

class AppParameter: AppParameterProtocol {
	
	@AppParameterStorage<Bool>(key: .isBeginningViewShowedOnce)
	var isBeginningViewShowedOnce
}
