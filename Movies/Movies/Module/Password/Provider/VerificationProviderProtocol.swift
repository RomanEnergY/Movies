//
//  VerificationProviderProtocol.swift
//  Movies
//
//  Created by Roman Zverik on 24.02.2021.
//  Copyright © 2021 ZRS. All rights reserved.
//

import Foundation

protocol VerificationProviderProtocol: class {
	var count: Int { get }
	var delegate: PasswordKeyProviderDelegate? { get set }

	func setFilled(count: Int)
	func addKey(key: PasswordView.Key)
}
