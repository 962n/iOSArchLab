//
//  StringExtTest.swift
//  FluxTests
//
//  Created by takahiro.kurokawa on 2019/12/04.
//  Copyright © 2019 962n. All rights reserved.
//

import XCTest

class StringExtTest: XCTestCase {
    
    func testRandomAlphanumericLength() {
        for _ in 0..<10 {
            let length = Int.random(in: 0...100)
            let result = String.randomAlphanumeric(length)
            print(result)
            assert(length == result.count)
        }
        
    }

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
//        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

}
