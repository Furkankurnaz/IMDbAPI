//
//  SearchModel.swift
//  iMDbAPI
//
//  Created by Furkan Kurnaz on 15.05.2019.
//  Copyright © 2019 Furkan Kurnaz. All rights reserved.
//

import Foundation

struct SearchModel {
    let search: [Media]
}

extension SearchModel: Decodable {
    enum SearchModelCodingKeys: String, CodingKey {
        case search = "Search"
    }
    
    init(from decoder : Decoder) throws {
        let container = try decoder.container(keyedBy: SearchModelCodingKeys.self)
        
        search = try container.decode([Media].self, forKey: .search)
    }
}
