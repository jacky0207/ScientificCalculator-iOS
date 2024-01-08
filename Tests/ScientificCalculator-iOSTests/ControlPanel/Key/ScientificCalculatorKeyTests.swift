//
//  ScientificCalculatorKeyTests.swift
//  
//
//  Created by Jacky Lam on 2024-01-08.
//

import XCTest
@testable import ScientificCalculator_iOS

final class ScientificCalculatorKeyTests: XCTestCase {
    override func setUpWithError() throws {

    }

    override func tearDownWithError() throws {

    }

    func testScientificCalculatorKey_keyFromRawValue_ReturnKey() {
        XCTAssertEqual(CalculatorKey.key(from: "1"), .number(.one))
        XCTAssertEqual(CalculatorKey.key(from: "+"), .operator(.plus))
        XCTAssertEqual(CalculatorKey.key(from: "sin"), .function(.sin))
        XCTAssertEqual(CalculatorKey.key(from: "a"), .variable(.a))
        XCTAssertEqual(CalculatorKey.key(from: "("), .bracket(.openBracket))
    }

    func testScientificCalculatorKey_keyFromRawValue_NotFound() {
        XCTAssertEqual(CalculatorKey.key(from: "abc"), nil)
    }
}
