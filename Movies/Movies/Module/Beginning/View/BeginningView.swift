//
//  BeginningView.swift
//  Movies
//
//  Created by Roman Zverik on 16.02.2021.
//  Copyright © 2021 ZRS. All rights reserved.
//

import UIKit
import SnapKit

struct BeginningViewCollectorData {
	var titleText: String = " 👋🤩 Привет!! 😉🤗"
	var itemFirstText: String = "\tЭто тестовое приложение - так сказать обзор/проработка методик работы на чистом Swift - и вот получилось приложение \"ФИЛЬМЫ\" 🥳"
	var itemSecondText: String = "\tНе судите строго - я не дизайнер 😅, а разработчик 🤯, но если будет поставлен четкий дизайн - поправим по Figma или Zeplin 😉"
	var itemThirdText: String = "\tПри разработке использовался стек, фишки и примочки:"
	var stack: [String] = ["XCode 12", "Swift 5+", "iOS 14.1", "Automatic Reference Count", "Grand Center Dispatch", "UIKit", "Digital integration (DI)", "Logger", "Property Wrapper", "UserDefaults", "SOLID", "YARCH", "Unit test", "CocoaPods", "SmartGit", "ColorSlurp", "Sublime Text", "Pastman", "Coogle Chrome", "NinjaMock", "Figma"]
	var itemFourthText: String = "\tВ данном проекте использовал следующие паттерны проектирования:"
	var patterns: [String] = ["Factory method", "Builder", "Singelton", "Adapter", "Bridge", "Delegate", "Decorator", "Facade", "Proxy", "Observer"]
	var itemFiveText: String = "\tПриложение находится на стадии: \"In development 🤯\" и каждый день оно улучшается и меняется в лучшую сторону - и это круто!!! 😇"
	var itemSixText: String = "Zverik Roman\nг.Санкт-Петербург\nтел: +7-951-651-25-99\nemail: Zverik.r.s@gmail.com"
}

protocol BeginningViewDelegate: class {
	func continueButtonPressed()
}

final class BeginningView: BaseView {
	
	// MARK: private var
	
	private let collectorData = BeginningViewCollectorData()
	private let bacgraundImage = UIImageView()
	private let blurEffect = UIBlurEffect()
	private let scrollView = UIScrollView()
	private let contentView = UIView()
	private let shadowRoundView = ShadowRoundView(image: UIImage(named: "Cinema"))
	private let titleLabel = UILabel()
	private let itemFirst = BeginningItemView()
	private let itemSecond = BeginningItemView()
	private let itemThird = BeginningItemView()
	private let itemFourth = BeginningItemView()
	private let itemFive = BeginningItemView()
	private let itemSix = BeginningItemView()

	private let continueButton = Dev.Button.create(devType: .regular)
	
	weak var delegate: BeginningViewDelegate?
	
	override func configure() {
		super.configure()
		
		backgroundColor = .white
		
		bacgraundImage.image = UIImage(named: "kino")
		bacgraundImage.alpha = 0.05
		
		shadowRoundView.shadowColor = Dev.Color.create(colorType: .shadowColorImageCinema)
		
		titleLabel.text = collectorData.titleText
		titleLabel.font = UIFont.boldSystemFont(ofSize: 21.0)
		titleLabel.textAlignment = .center
		titleLabel.numberOfLines = 0
		
		itemFirst.set(title: collectorData.itemFirstText)
		itemSecond.set(title: collectorData.itemSecondText)
		itemThird.set(title: collectorData.itemThirdText)
		itemThird.set(items: collectorData.stack, separate: "🔸")
		itemFourth.set(title: collectorData.itemFourthText)
		itemFourth.set(items: collectorData.patterns, separate: "🔹")
		itemFive.set(title: collectorData.itemFiveText, font: UIFont.boldSystemFont(ofSize: 16))
		itemSix.set(title: collectorData.itemSixText, font: UIFont.italicSystemFont(ofSize: 12), alignment: .right)
		
		continueButton.setTitle("Send", for: .normal)
		continueButton.addTarget(self, action: #selector(continueButtonPressed), for: .touchUpInside)
	}
	
	override func addSubviews() {
		super.addSubviews()
		
		addSubview(bacgraundImage)
		addSubview(scrollView)
		
		scrollView.addSubview(contentView)
		contentView.addSubview(shadowRoundView)
		contentView.addSubview(titleLabel)
		contentView.addSubview(itemFirst)
		contentView.addSubview(itemSecond)
		contentView.addSubview(itemThird)
		contentView.addSubview(itemFourth)
		contentView.addSubview(itemFive)
		contentView.addSubview(itemSix)
		contentView.addSubview(continueButton)
	}
	
	override func makeConstraints() {
		bacgraundImage.snp.makeConstraints { (make) in
			make.top.equalToSuperview().inset(allBarsHeight)
			make.left.right.bottom.equalToSuperview()
		}
		
		scrollView.snp.makeConstraints { (make) in
			make.top.equalToSuperview().inset(allBarsHeight)
			make.left.right.bottom.equalToSuperview()
		}
		
		contentView.snp.makeConstraints { (make) in
			make.edges.centerX.equalToSuperview()
		}
		
		shadowRoundView.snp.makeConstraints { make in
			make.top.equalToSuperview().inset(20)
			make.left.right.equalToSuperview().inset(20)
			make.height.equalTo(100)
		}
		
		titleLabel.snp.makeConstraints { make in
			make.top.equalTo(shadowRoundView.snp.bottom).offset(40)
			make.left.right.equalToSuperview().inset(20)
		}
		
		itemFirst.snp.makeConstraints { make in
			make.top.equalTo(titleLabel.snp.bottom).offset(8)
			make.left.right.equalToSuperview().inset(20)
		}
		
		itemSecond.snp.makeConstraints { make in
			make.top.equalTo(itemFirst.snp.bottom).offset(8)
			make.left.right.equalToSuperview().inset(20)
		}
		
		itemThird.snp.makeConstraints { make in
			make.top.equalTo(itemSecond.snp.bottom).offset(8)
			make.left.right.equalToSuperview().inset(20)
		}
		
		itemFourth.snp.makeConstraints { make in
			make.top.equalTo(itemThird.snp.bottom).offset(20)
			make.left.right.equalToSuperview().inset(20)
		}
		
		itemFive.snp.makeConstraints { make in
			make.top.equalTo(itemFourth.snp.bottom).offset(20)
			make.left.right.equalToSuperview().inset(20)
		}
		
		itemSix.snp.makeConstraints { make in
			make.top.equalTo(itemFive.snp.bottom).offset(50)
			make.left.right.equalToSuperview().inset(20)
		}
		
		continueButton.snp.makeConstraints { make in
			make.top.equalTo(itemSix.snp.bottom)
			make.left.right.equalToSuperview().inset(20)
			make.bottom.equalToSuperview().inset(20)
			make.height.equalTo(40)
		}
		
		super.makeConstraints()
	}
	
	@objc private func continueButtonPressed() {
		delegate?.continueButtonPressed()
	}
}
