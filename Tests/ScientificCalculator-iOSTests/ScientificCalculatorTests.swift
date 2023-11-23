//
//  ScientificCalculatorTests.swift
//  ScientificCalculatorTests
//
//  Created by Jacky Lam on 2023-11-17.
//

import XCTest
@testable import ScientificCalculator_iOS

final class ScientificCalculatorTests: XCTestCase {
    let calculator: Calculator = ScientificCalculator()

    override func setUpWithError() throws {
        
    }

    override func tearDownWithError() throws {
        
    }

    func testScientificCalculator_AppendKey() throws {
        calculator.appendKey(.number(.one))
        XCTAssertEqual(calculator.text, "1")
    }

    func testScientificCalculator_Delete() throws {
        calculator.appendKey(.number(.one))
        calculator.appendKey(.number(.two))
        calculator.delete()
        XCTAssertEqual(calculator.text, "1")
    }

    func testScientificCalculator_ClearAll() throws {
        calculator.appendKey(.number(.one))
        calculator.appendKey(.number(.two))
        try calculator.calculate()
        calculator.clearAll()
        XCTAssertEqual(calculator.text, "")
        XCTAssertEqual(calculator.answer, 0)
    }

    func testScientificCalculator_Calculate() throws {
        calculator.appendKey(.number(.two))
        calculator.appendKey(.function(.openBracket))
        calculator.appendKey(.function(.openBracket))
        calculator.appendKey(.number(.one))
        calculator.appendKey(.operator(.plus))
        calculator.appendKey(.number(.two))
        calculator.appendKey(.function(.closeBracket))
        calculator.appendKey(.operator(.multiply))
        calculator.appendKey(.number(.three))
        calculator.appendKey(.function(.closeBracket))
        calculator.appendKey(.function(.sin))
        calculator.appendKey(.number(.three))
        calculator.appendKey(.number(.zero))
        try calculator.calculate()
        XCTAssertEqual(calculator.answer, 9)
    }
}
