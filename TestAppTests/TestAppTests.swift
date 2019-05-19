//
//  TestAppTests.swift
//  TestAppTests
//
//  Created by Keyhan on 5/17/19.
//  Copyright © 2019 Keyhan. All rights reserved.
//

import XCTest
@testable import TestApp

class TestAppTests: XCTestCase {
    var viewModel: ResourceDetailViewModel!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }

    func testJSONDecoding() {
        
        // Convert restaurant.json to Data
        
        let testBundle = Bundle(for: type(of: self))
        let path = testBundle.path(forResource: "restaurants", ofType: "json")
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: path!), options: .alwaysMapped) else {
            fatalError("Data is nil")
        }
        
        // Provie any Codable struct
        let resource = try! JSONDecoder().decode(Resources.self, from: data)
        
        XCTAssertEqual(resource.first?.title, "Pizza Spanos")
    }

    func testResourceDetailViewModel() {
        let testBundle = Bundle(for: type(of: self))
        let path = testBundle.path(forResource: "restaurants", ofType: "json")
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: path!), options: .alwaysMapped) else {
            fatalError("Data is nil")
        }
        
        let resource = try! JSONDecoder().decode(Resources.self, from: data)
        
        guard let firResource = resource.first else {
            fatalError("First Resource is nil")
        }
        
        viewModel = ResourceDetailViewModel(resource: firResource)
        
        XCTAssertEqual(viewModel.title, "Pizza Spanos")
    }
}
