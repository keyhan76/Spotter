//
//  TestAppSlowTests.swift
//  TestAppSlowTests
//
//  Created by Keyhan on 5/19/19.
//  Copyright © 2019 Keyhan. All rights reserved.
//

import XCTest
@testable import TestApp

class TestAppSlowTests: XCTestCase {
    
    var sessionUnderTest: URLSession!
    
    override func setUp() {
        super.setUp()
        sessionUnderTest = URLSession(configuration: URLSessionConfiguration.default)
    }
    
    override func tearDown() {
        sessionUnderTest = nil
        super.tearDown()
    }

    // Asynchronous test: success fast, failure slow
    func testValidCallToGithubGetsHTTPStatusCode200() {
        
        // given
        let url = URL(string: "https://raw.githubusercontent.com/AmirDaliri/getTestJson/master/restaurants.json")
        
        let promise = expectation(description: "Completion handler invoked")
        var statusCode: Int?
        var responseError: Error?
        
        // when
        let dataTask = sessionUnderTest.dataTask(with: url!) { data, response, error in
            statusCode = (response as? HTTPURLResponse)?.statusCode
            responseError = error
            
            promise.fulfill()
        }
        dataTask.resume()
        
        waitForExpectations(timeout: 5, handler: nil)
        
        // then
        XCTAssertNil(responseError)
        XCTAssertEqual(statusCode, 200)
    }

}
