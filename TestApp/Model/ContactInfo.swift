//
//  ContactInfo.swift
//  TestApp
//
//  Created by Keyhan on 5/17/19.
//  Copyright © 2019 Keyhan. All rights reserved.
//

import Foundation

// MARK: - Contact Info
struct ContactInfo: Codable {
    let website: [String]?
    let email: [String]?
    let phoneNumber: [String]?
    let faxNumber, tollFree: [String]?
}
