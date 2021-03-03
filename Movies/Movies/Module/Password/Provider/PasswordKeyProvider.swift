//
//  PasswordKeyProvider.swift
//  Movies
//
//  Created by Roman Zverik on 23.02.2021.
//  Copyright © 2021 ZRS. All rights reserved.
//

import Foundation

protocol PasswordKeyProviderProtocol: class {
	var count: Int { get }
	var verificationProvider: VerificationProviderProtocol? { get set }
	var delegate: PasswordKeyProviderDelegate? { get set }
	
	func setFilled(count: Int)
	func addKey(key: PasswordView.Key)
}

protocol PasswordKeyProviderDelegate: class {
	func updateKeyStatus(count: Int)
	func filledFirstKey()
	func resetKey()
	func errorInput()
	func verificationKeySuccess(password: String)
}

final class PasswordKeyProvider: PasswordKeyProviderProtocol {
	
	// MAKR: - private variable
	private var countFilled = 5 {
		didSet {
			verificationProvider?.setFilled(count: countFilled)
		}
	}
	weak var delegate: PasswordKeyProviderDelegate?
	
	var verificationProvider: VerificationProviderProtocol? {
		didSet {
			verificationProvider?.setFilled(count: countFilled)
			verificationProvider?.delegate = delegate
		}
	}
	
	// MAKR: - public variable
	
	var count: Int {
		guard let verificationProvider = verificationProvider else { return 0 }
		return verificationProvider.count
	}
	
	// MAKR: - public functions
	
	func setFilled(count: Int) {
		countFilled = count
	}
	
	func addKey(key: PasswordView.Key) {
		verificationProvider?.addKey(key: key)
	}
}
