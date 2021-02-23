//
//  VerificationEntranceProvider.swift
//  Movies
//
//  Created by Roman Zverik on 24.02.2021.
//  Copyright © 2021 ZRS. All rights reserved.
//

import Foundation

final class VerificationEntranceProvider: VerificationProviderProtocol {
	
	// MAKR: - private variable
	
	private var tempKey = ""
	private var countFilled = 5
	private let password: String
	var delegate: PasswordKeyProviderDelegate?
	
	init(password: String) {
		self.password = password
	}
	
	// MAKR: - public variable
	
	var count: Int {
		tempKey.count
	}
	
	// MAKR: - public functions
	
	func setFilled(count: Int) {
		countFilled = count
	}
	
	func addKey(key: PasswordView.Key) {
		update(password: &tempKey, key: key)
		delegate?.updateKeyStatus(count: count)
		if tempKey.count == countFilled {
			if tempKey == password {
				delegate?.verificationKeySuccess(password: tempKey)
			}
			else {
				tempKey = ""
				delegate?.errorInput()
			}
		}
	}
	
	private func update(password: inout String, key: PasswordView.Key) {
		if key == .remove {
			if !password.isEmpty {
				password.removeLast()
			}
		}
		else {
			password += key.rawValue
		}
	}
}
