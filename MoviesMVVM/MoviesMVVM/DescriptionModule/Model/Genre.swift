//
//  Genre.swift
//  MoviesMVVM
//
//  Created by 1234 on 15.09.2020.
//  Copyright © 2020 ZRS. All rights reserved.
//

import Foundation

struct Genre {
    let name: String
}

extension Genre: Decodable {
    
    enum GenreCodingKeys: String, CodingKey {
        case name
    }
    
    init(from decoder: Decoder) throws {
        let genreContainer = try decoder.container(keyedBy: GenreCodingKeys.self)
        
        name = try genreContainer.decode(String.self, forKey: .name)
    }
}
