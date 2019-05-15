//
//  SearchViewModel.swift
//  iMDbAPI
//
//  Created by Furkan Kurnaz on 15.05.2019.
//  Copyright © 2019 Furkan Kurnaz. All rights reserved.
//

import UIKit

class SearchViewModel {
    private var types: [String] = []
    private var years: [String] = []
    
    func getTypes() -> [String] {
        types = [
            "Movies",
            "Series",
            "Episode"
        ]
        
        return types
    }
    
    func getYears() -> [String] {
        let currentYear = Calendar.current.component(.year, from: Date())
        
        for year in 1900 ... currentYear {
            years.insert(String(year), at: 0)
        }
        
        return years
    }
    
}

enum PickerViewType {
    case type
    case year
}
