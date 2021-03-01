//
//  MovieFeedContentView.swift
//  Movies
//
//  Created by Roman Zverik on 26.02.2021.
//  Copyright © 2021 ZRS. All rights reserved.
//

import UIKit
import SnapKit

final class MovieFeedContentView: BaseView {
	
	private let titleLabel = UILabel()
	private let overviewLabel = UILabel()
	private let releaseDateLabel = UILabel()
	
	override func configure() {
		titleLabel.textAlignment = .center
		titleLabel.font = UIFont.boldSystemFont(ofSize: 14)
		titleLabel.numberOfLines = 0
		titleLabel.contentMode = .top
		
		overviewLabel.font = UIFont.italicSystemFont(ofSize: 12)
		overviewLabel.numberOfLines = 0
		overviewLabel.contentMode = .topLeft
		overviewLabel.lineBreakMode = .byTruncatingTail
		
		releaseDateLabel.textAlignment = .right
		releaseDateLabel.font = UIFont.italicSystemFont(ofSize: 12)
	}
	
	override func addSubviews() {
		addSubview(titleLabel)
		addSubview(overviewLabel)
		addSubview(releaseDateLabel)
	}
	
	override func makeConstraints() {
		titleLabel.snp.makeConstraints { make in
			make.top.equalToSuperview().inset(5).priority(.high)
			make.left.right.equalToSuperview().inset(5)
		}
		
		overviewLabel.snp.makeConstraints { make in
			make.top.equalTo(titleLabel.snp.bottom)
			make.left.equalTo(titleLabel.snp.left)
			make.right.equalTo(titleLabel.snp.right)
			make.bottom.equalToSuperview().inset(15)
		}
		
		releaseDateLabel.snp.makeConstraints { make in
			make.bottom.right.equalToSuperview()
		}
	}
	
	func update(data: MainModelMovieProtocol) {
		titleLabel.text = data.title
		overviewLabel.text = "\t\(data.overview)"
		
		guard let date = data.releaseDate else { return }
		releaseDateLabel.text = dateFormatterString(date)
	}
	
	private func dateFormatterString(_ date: Date) -> String {
		let dateFormatter = DateFormatter()
		dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
		dateFormatter.locale = Locale(identifier: "ru_RU")
		dateFormatter.dateFormat = "dd MMM yyyy"
		
		return dateFormatter.string(from: date)
	}
}
