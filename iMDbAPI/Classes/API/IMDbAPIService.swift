//
//  IMDbAPIService.swift
//  iMDbAPI
//
//  Created by Furkan Kurnaz on 15.05.2019.
//  Copyright © 2019 Furkan Kurnaz. All rights reserved.
//

import Moya

enum IMDbAPIService {
    case search(title: String, type: String?, year: String?)
}

extension IMDbAPIService: TargetType {
    var baseURL: URL {
        return URL(string: "http://www.omdbapi.com/")!
    }
    
    var path: String {
        return ""
    }
    
    var method: Method {
        switch self {
        case .search:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
    }
    
    var parameters: [String : Any] {
        switch self {
        case .search(let title, let type, let year):
            var parameters = [String:Any]()
            parameters["apikey"] = "fb85c6a1"
            parameters["s"] = title
            
            if let type = type{
                parameters["type"] = type
            }
            
            if let year = year {
                parameters["y"] = year
            }
            
            return parameters
        }
    }

    var headers: [String : String]? {
        return nil
    }
    
    
}
