//
//  DataService.swift
//  TestApp
//
//  Created by Keyhan on 5/17/19.
//  Copyright © 2019 Keyhan. All rights reserved.
//

import Foundation

class DataService: APIClient {
    
    // APIClient Protocol Variable
    var session: URLSession = URLSession(configuration: .default)
    
    // Private init
    private init() { }
    
    // Singelton
    static let shared: DataService = DataService()
    
    // typealias for completion handler
    typealias JSONTaskCompletionHandler<T: Decodable> = (Result<T, APIError>) -> Void
    
    // MARK: - Network Calls
    
    /// Get Categories data, Restaurants data, Vactions data
    /// - parameters:
    ///   - requestType: The request type can be: categories, restaurant & vaction.
    ///   - decodeType: The Decodable struct to decode.
    ///   - completion: completion handler.
    func getFeed<T: Decodable>(from resourceType: ResourceType, decodeType: T.Type, completion: @escaping JSONTaskCompletionHandler<T>) {
        let endpoint = resourceType
        let request = endpoint.request
        
        fetch(with: request, decode: { json -> T? in
            guard let feedResult = json as? T else { return  nil }
            return feedResult
        }, completion: completion)
    }
    
    // MARK: - Helpers
    
    /// JSON Decoder
    private func jsonDecoder() -> JSONDecoder {
        let decoder = JSONDecoder()
        if #available(iOS 10.0, *) {
            decoder.dateDecodingStrategy = .iso8601
        }
        return decoder
    }
    
    /// JSON Encoder
    private func jsonEncoder() -> JSONEncoder {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        if #available(iOS 10.0, *) {
            encoder.dateEncodingStrategy = .iso8601
        }
        return encoder
    }
}
