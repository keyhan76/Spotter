//
//  Address.swift
//  TestApp
//
//  Created by Keyhan on 5/17/19.
//  Copyright © 2019 Keyhan. All rights reserved.
//

import Foundation

// MARK: - Address
struct Address: Codable {
    let address1, label, zipCode, city: String?
    let state, country: String?
    let gps: Gps?
}
