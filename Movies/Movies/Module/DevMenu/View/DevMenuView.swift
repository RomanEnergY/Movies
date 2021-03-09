//
//  DevMenuView.swift
//  Movies
//
//  Created by Roman Zverik on 04.03.2021.
//  Copyright © 2021 ZRS. All rights reserved.
//

import UIKit
import SnapKit

protocol DevMenuViewDelegate: class {
	func goNextModal(module: ModuleBuilder)
	func goNextPush(module: ModuleBuilder)
}

final class DevMenuView: BaseView {
	
	// MARK: - Types
	
	enum TableType {
		case appParameter
	}
	
	// MARK: - private variables
	
	private let tableView = Dev.Table.create()
	private var devMenuTableViewCells = [IndexPath: DevMenuTableViewCellProtocol]()
	private var data: [TableType] { [.appParameter, .appParameter, .appParameter] }
	
	// MARK: - public variables
	
	weak var delegate: DevMenuViewDelegate?
	
	// MARK: - lifecycle
	
	override func configure() {
		super.configure()
		
		backgroundColor = Dev.Color.create(colorType: .white)
		
		tableView.delegate = self
		tableView.dataSource = self
		tableView.separatorStyle = .singleLine

		registratinCell()
	}
	
	override func addSubviews() {
		super.addSubviews()
		
		addSubview(tableView)
	}
	
	override func makeConstraints() {
		super.makeConstraints()
		
		tableView.snp.makeConstraints { make in
			make.top.equalTo(safeAreaLayoutGuide.snp.top)
			make.left.right.bottom.equalToSuperview()
		}
	}
	
	//MARK: - private function
	
	private func registratinCell() {
		tableView.register(AppParameterDevMenuTableCell.self, forCellReuseIdentifier: AppParameterDevMenuTableCell.reuseIdentifier)
	}
}

extension DevMenuView: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return data.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		switch data[indexPath.row] {
			case .appParameter:
				let cell = tableView.dequeueReusableCell(withIdentifier: AppParameterDevMenuTableCell.reuseIdentifier, for: indexPath) as! AppParameterDevMenuTableCell
				devMenuTableViewCells[indexPath] = cell
				cell.delegate = self
				
				return cell
		}
	}
}

extension DevMenuView: DevMenuGoNextModuleDelegate {
	func goNextModal(module: ModuleBuilder) {
		delegate?.goNextModal(module: module)
	}
	
	func goNextPush(module: ModuleBuilder) {
		delegate?.goNextPush(module: module)
	}
}

extension DevMenuView: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		devMenuTableViewCells[indexPath]?.actionCell()
	}
}
