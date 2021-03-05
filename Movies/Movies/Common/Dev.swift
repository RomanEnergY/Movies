//
//  Dev.swift
//  Movies
//
//  Created by Roman Zverik on 18.02.2021.
//  Copyright © 2021 ZRS. All rights reserved.
//

import UIKit

enum Dev {
	struct Button {
		static func create(devType: BaseButton.DevType) -> BaseButton {
			return BaseButton(devType: devType)
		}
	}
	
	struct Color {
		private static var colorsCache = [String: UIColor]()
		private static let logger: LoggerProtocol = DI.container.resolve(LoggerProtocol.self)
		
		static func create(colorType: ColorType) -> UIColor {
			if let hexCode = colorType.rawValue.transformToHexCode() {
				if let color = colorsCache[hexCode] {
					return color
				}
				else {
					let color = UIColor.create(hex: hexCode)
					colorsCache[hexCode] = color
					return color
				}
			}
			else {
				logger.log(.warning, "transformToHexCode: [\(colorType.rawValue)] -> NOT CORRECT")
				if let color = colorsCache["nil"] {
					return color
				}
				else {
					let color = UIColor.gray
					colorsCache["nil"] = color
					return color
				}
			}
		}
	}
	
	struct Table {
		static func create() -> UITableView {
			let tableView = UITableView()
			
			if #available(iOS 11.0, *) {
				tableView.contentInsetAdjustmentBehavior = .never
			}
			
			tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
			tableView.rowHeight = UITableView.automaticDimension
			tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
			
			return tableView
		}
	}
}
