//
//  SearchViewModel.swift
//  iMDbAPI
//
//  Created by Furkan Kurnaz on 15.05.2019.
//  Copyright © 2019 Furkan Kurnaz. All rights reserved.
//

import UIKit
import Moya

class SearchViewModel {
    private var types: [String] = []
    private var years: [String] = []
    
    private var searchResults: SearchModel!
    
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
    
    func getMedia(title: String, type: String?, year: String) {
        let pluginsArray:[PluginType] = [NetworkLoggerPlugin(cURL: true)]
        let provider = MoyaProvider<IMDbAPIService>(plugins: pluginsArray)
        
        provider.request(.search(title: title, type: type, year: year)) { (response) in
            switch response {
            case .success(let value):
                let data = value.data
                
                do {
                    let results = try JSONDecoder().decode(SearchModel.self, from: data)
                    
                    self.searchResults = results
                    
                    //
                    for res in self.searchResults.search {
                        print(res)
                    }
                    //
                    
                } catch let error {
                    print(error)
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
}

enum PickerViewType {
    case type
    case year
}
