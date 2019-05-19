//
//  HTTPURLResponseExt.swift
//  TestApp
//
//  Created by Keyhan on 5/17/19.
//  Copyright © 2019 Keyhan. All rights reserved.
//

import Foundation

// MARK: - HTTPURLResponse Extension to check the success response code
extension HTTPURLResponse {
    var hasSuccessStatusCode: Bool {
        return 200...299 ~= statusCode
    }
}
