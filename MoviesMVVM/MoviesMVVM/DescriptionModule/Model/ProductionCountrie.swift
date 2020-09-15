//
//  ProductionCountrie.swift
//  MoviesMVVM
//
//  Created by 1234 on 15.09.2020.
//  Copyright © 2020 ZRS. All rights reserved.
//

import Foundation

struct ProductionCountrie {
    let name: String
}

extension ProductionCountrie: Decodable {
    
    enum ProductionCountrieCodingKeys: String, CodingKey {
        case name
    }
    
    init(from decoder: Decoder) throws {
        let genreContainer = try decoder.container(keyedBy: ProductionCountrieCodingKeys.self)
        
        name = try genreContainer.decode(String.self, forKey: .name)
    }
}
