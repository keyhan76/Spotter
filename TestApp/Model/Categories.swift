//
//  Categories.swift
//  TestApp
//
//  Created by Keyhan on 5/18/19.
//  Copyright © 2019 Keyhan. All rights reserved.
//

import Foundation

typealias Categories = [Category]

struct Category: Codable {
    let id, updatedAt, slug, customModuleEid: String
    let eid, title: String
    let description: String?
    let v: Int
    let active: Bool
    let createdAt: String
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case updatedAt = "updated_at"
        case slug
        case customModuleEid = "custom_module_eid"
        case eid, title, description
        case v = "__v"
        case active = "_active"
        case createdAt = "created_at"
    }
}
