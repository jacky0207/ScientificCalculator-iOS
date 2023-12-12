//
//  ScientificCalculatorFactorialCommandTests.swift
//  ScientificCalculatorTests
//
//  Created by Jacky Lam on 2023-11-20.
//

import XCTest
@testable import ScientificCalculator_iOS

final class ScientificCalculatorFactorialCommandTests: XCTestCase {
    let factorialCommand: CalculatorCommand = ScientificCalculatorFactorialCommand()

    override func setUpWithError() throws {

    }

    override func tearDownWithError() throws {

    }

    func testScientificCalculatorFactorialCommand_Factorial() throws {
        let nodes = CalculatorKeyList()
        let `operator` = CalculatorKeyNode(key: .function(.factorial))
        nodes.append(.number(.four))
        nodes.append(from: `operator`)
        let result = try factorialCommand.execute(node: `operator`, params: [:])
        XCTAssertEqual(result.head.key.text, "4")
        XCTAssertEqual(result.tail.key.text, "!")
        XCTAssertEqual(result.newKeys.text, "24")
    }

    func testScientificCalculatorFactorialCommand_NumberTail_ThrowSyntaxError() throws {
        let nodes = CalculatorKeyList()
        let `operator` = CalculatorKeyNode(key: .function(.factorial))
        nodes.append(.number(.four))
        nodes.append(from: `operator`)
        nodes.append(.number(.one))
        XCTAssertThrowsError( try factorialCommand.execute(node: `operator`, params: [:])) { error in
            XCTAssertEqual(error as? CalculatorError, .syntax)
        }
    }

    func testScientificCalculatorFactorialCommand_NotIntegerHead_ThrowSyntaxError() throws {
        let nodes = CalculatorKeyList()
        let `operator` = CalculatorKeyNode(key: .function(.factorial))
        nodes.append(.number(.four))
        nodes.append(.number(.dot))
        nodes.append(.number(.one))
        nodes.append(from: `operator`)
        XCTAssertThrowsError( try factorialCommand.execute(node: `operator`, params: [:])) { error in
            XCTAssertEqual(error as? CalculatorError, .math)
        }
    }

    func testScientificCalculatorFactorialCommand_NegativeHead_MultiplyNegativeOne() throws {
        let nodes = CalculatorKeyList()
        let `operator` = CalculatorKeyNode(key: .function(.factorial))
        nodes.append(.operator(.minus))
        nodes.append(.number(.four))
        nodes.append(from: `operator`)
        let result = try factorialCommand.execute(node: `operator`, params: [:])
        XCTAssertEqual(result.head.key.text, "-")
        XCTAssertEqual(result.tail.key.text, "!")
        XCTAssertEqual(result.newKeys.text, "-24")
    }

    func testScientificCalculatorFactorialCommand_ZeroHead_ReturnOne() throws {
        let nodes = CalculatorKeyList()
        let `operator` = CalculatorKeyNode(key: .function(.factorial))
        nodes.append(.number(.zero))
        nodes.append(from: `operator`)
        let result = try factorialCommand.execute(node: `operator`, params: [:])
        XCTAssertEqual(result.head.key.text, "0")
        XCTAssertEqual(result.tail.key.text, "!")
        XCTAssertEqual(result.newKeys.text, "1")
    }

    func testScientificCalculatorFactorialCommand_OneHead_ReturnOne() throws {
        let nodes = CalculatorKeyList()
        let `operator` = CalculatorKeyNode(key: .function(.factorial))
        nodes.append(.number(.one))
        nodes.append(from: `operator`)
        let result = try factorialCommand.execute(node: `operator`, params: [:])
        XCTAssertEqual(result.head.key.text, "1")
        XCTAssertEqual(result.tail.key.text, "!")
        XCTAssertEqual(result.newKeys.text, "1")
    }
}
