//
//  Media.swift
//  iMDbAPI
//
//  Created by Furkan Kurnaz on 15.05.2019.
//  Copyright © 2019 Furkan Kurnaz. All rights reserved.
//

import Foundation

struct Media {
    let title: String
    let year: String
    let id: String
    let type: String
    let poster: String
}

extension Media: Decodable {
    enum MediaCodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case id = "imdbID"
        case type = "Type"
        case poster = "Poster"
    }
    
    init(from decoder : Decoder) throws {
        let container = try decoder.container(keyedBy: MediaCodingKeys.self)
        
        title = try container.decode(String.self, forKey: .title)
        year = try container.decode(String.self, forKey: .year)
        id = try container.decode(String.self, forKey: .id)
        type = try container.decode(String.self, forKey: .type)
        poster = try container.decode(String.self, forKey: .poster)
    }
}
