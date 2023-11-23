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
        let result = try factorialCommand.execute(node: `operator`)
        XCTAssertEqual(result.head.key.text, "4")
        XCTAssertEqual(result.tail.key.text, "!")
        XCTAssertEqual(result.newKeys.text, "24")
    }

    func testScientificCalculatorFactorialCommand_NumberTail_InvalidTail() throws {
        let nodes = CalculatorKeyList()
        let `operator` = CalculatorKeyNode(key: .function(.factorial))
        nodes.append(.number(.four))
        nodes.append(from: `operator`)
        nodes.append(.number(.one))
        XCTAssertThrowsError( try factorialCommand.execute(node: `operator`)) { error in
            XCTAssertEqual(error as? CalculatorCommandError, CalculatorCommandError.invalidTail)
        }
    }

    func testScientificCalculatorFactorialCommand_NotIntegerHead_InvalidHead() throws {
        let nodes = CalculatorKeyList()
        let `operator` = CalculatorKeyNode(key: .function(.factorial))
        nodes.append(.number(.four))
        nodes.append(.number(.dot))
        nodes.append(.number(.one))
        nodes.append(from: `operator`)
        XCTAssertThrowsError( try factorialCommand.execute(node: `operator`)) { error in
            XCTAssertEqual(error as? CalculatorCommandError, CalculatorCommandError.invalidHead)
        }
    }

    func testScientificCalculatorFactorialCommand_NegativeHead_MultiplyNegativeOne() throws {
        let nodes = CalculatorKeyList()
        let `operator` = CalculatorKeyNode(key: .function(.factorial))
        nodes.append(.operator(.minus))
        nodes.append(.number(.four))
        nodes.append(from: `operator`)
        let result = try factorialCommand.execute(node: `operator`)
        XCTAssertEqual(result.head.key.text, "-")
        XCTAssertEqual(result.tail.key.text, "!")
        XCTAssertEqual(result.newKeys.text, "-24")
    }
}
