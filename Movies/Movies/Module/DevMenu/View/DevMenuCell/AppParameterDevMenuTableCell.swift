//
//  AppParameterDevMenuTableCell.swift
//  Movies
//
//  Created by Roman Zverik on 06.03.2021.
//  Copyright © 2021 ZRS. All rights reserved.
//

import UIKit

final class AppParameterDevMenuTableCell: BaseTableViewCell, DevMenuTableViewCellProtocol {
	
	// MARK: - private variables
	
	private let customView = DevMenuPresentNextView()
	private let goNextModule: ModuleBuilder = DevMenuAppParameterBuilder()
	
	// MARK: - public variables
	
	weak var delegate: DevMenuGoNextModuleDelegate? {
		didSet {
			customView.delegate = delegate
		}
	}
	
	// MARK: - lifecycle
	
	override func configure() {
		super.configure()
		
		customView.update(text: "Параметры приложения")
		customView.goNextModule = goNextModule
		customView.type = .push
	}
	
	override func addSubviews() {
		super.addSubviews()
		
		addSubview(customView)
	}
	
	override func makeConstraints() {
		super.makeConstraints()
		
		customView.snp.makeConstraints { make in
			make.edges.equalToSuperview()
		}
	}
	
	// MARK: - public methods
	
	func actionCell() {
		customView.action()
	}
}
