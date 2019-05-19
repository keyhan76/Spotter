//
//  Restaurants.swift
//  TestApp
//
//  Created by Keyhan on 5/17/19.
//  Copyright © 2019 Keyhan. All rights reserved.
//

import Foundation

// Create a typealias of Restaurants array
typealias Resources = [Resource]

// MARK: - Restaurant
struct Resource: Codable {
    let id, slug, eid, title: String
    let description, categoryEid: String
    let version: Int
    let photo: String
    let active: Bool
    let updatedAt, createdAt: String
    let addresses, freeText: [Address]?
    let contactInfo: ContactInfo
    let bizHours: BizHours?
    let socialMedia: SocialMedia?
    
    // CodingKey
    private enum CodingKeys: String, CodingKey {
        case id = "_id"
        case slug, eid, title, description
        case categoryEid = "category_eid"
        case version = "__v"
        case photo
        case active = "_active"
        case updatedAt = "updated_at"
        case createdAt = "created_at"
        case addresses, contactInfo, bizHours, socialMedia, freeText
    }
}

// MARK: - GPS Data
struct Gps: Codable {
    let latitude, longitude: String
}

// MARK: - Working Days
struct BizHours: Codable {
    let sunday, monday: Days
}

// MARK: - Wroking Hours
struct Days: Codable {
    let from, to: String
}
