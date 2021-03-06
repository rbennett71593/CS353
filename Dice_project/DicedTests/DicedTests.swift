//
//  DicedTests.swift
//  DicedTests
//
//  Created by Ryan Bennett on 2/18/16.
//  Copyright © 2016 bennry01. All rights reserved.
//

import XCTest
@testable import Diced

class DicedTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        var dice = [Die]()
        for _ in 1...5{
            dice.append(Die(possibleValues:["⚀", "⚁", "⚂", "⚃", "⚄", "⚅"]))
        }
        XCTAssertEqual(dice[0].value,"⚄")
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
