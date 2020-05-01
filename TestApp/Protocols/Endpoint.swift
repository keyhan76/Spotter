//
//  Endpoint.swift
//  TestApp
//
//  Created by Keyhan on 5/17/19.
//  Copyright © 2019 Keyhan. All rights reserved.
//

import Foundation

protocol Endpoint {
    
    var base: String { get }
    var path: String { get }
}

extension Endpoint {
    
    var urlComponents: URLComponents {
        var components = URLComponents(string: base)!
        components.path = path
        return components
    }
    
    var request: URLRequest {
        let url = urlComponents.url!
        return URLRequest(url: url)
    }
}

enum ResourceType {
    case categories
    case restaurants
    case vacation
}

extension ResourceType: Endpoint {
    
    var base: String {
        return "https://raw.githubusercontent.com"
    }
    
    var path: String {
        switch self {
        case .categories: return "/keyhan76/TestJSON/master/categories.json"
        case .restaurants: return "/keyhan76/TestJSON/master/restaurants.json"
        case .vacation: return "/keyhan76/TestJSON/master/vacation-spot.json"
        }
    }
}
