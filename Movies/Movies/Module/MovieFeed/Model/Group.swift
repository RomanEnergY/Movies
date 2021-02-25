//
//  Group.swift
//  Movies
//
//  Created by Roman Zverik on 25.09.2020.
//  Copyright © 2020 ZRS. All rights reserved.
//

import Foundation

enum Group: String, CaseIterable {
	case trending = "В тренде"
	case nowPlaying = "Смотрят сейчас"
	case popular = "Популярные"
	case topRated = "Высокий рейтинг"
	case upcoming = "Предстоящие"
}
