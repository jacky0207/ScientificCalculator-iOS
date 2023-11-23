//
//  ScientificCalculatorTrigonometricCommandTests.swift
//  ScientificCalculatorTests
//
//  Created by Jacky Lam on 2023-11-22.
//

import XCTest
@testable import ScientificCalculator_iOS

final class ScientificCalculatorTrigonometricCommandTests: XCTestCase {
    let sinCommand: CalculatorCommand = ScientificCalculatorSinCommand()
    let cosCommand: CalculatorCommand = ScientificCalculatorCosCommand()
    let tanCommand: CalculatorCommand = ScientificCalculatorTanCommand()

    override func setUpWithError() throws {

    }

    override func tearDownWithError() throws {

    }

    func testScientificCalculatorTrigonometricCommand_Sin_Execute() throws {
        let nodes = CalculatorKeyList()
        let `operator` = CalculatorKeyNode(key: .function(.sin))
        nodes.append(from: `operator`)
        nodes.append(.number(.three))
        nodes.append(.number(.zero))
        let result = try sinCommand.execute(node: `operator`)
        XCTAssertEqual(result.head.key.text, "sin")
        XCTAssertEqual(result.tail.key.text, "0")
        XCTAssertEqual(result.newKeys.text, "0.5")
    }

    func testScientificCalculatorTrigonometricCommand_Cos_Execute() throws {
        let nodes = CalculatorKeyList()
        let `operator` = CalculatorKeyNode(key: .function(.cos))
        nodes.append(from: `operator`)
        nodes.append(.number(.six))
        nodes.append(.number(.zero))
        let result = try cosCommand.execute(node: `operator`)
        XCTAssertEqual(result.head.key.text, "cos")
        XCTAssertEqual(result.tail.key.text, "0")
        XCTAssertEqual(result.newKeys.text, "0.5")
    }

    func testScientificCalculatorTrigonometricCommand_Tan_Execute() throws {
        let nodes = CalculatorKeyList()
        let `operator` = CalculatorKeyNode(key: .function(.tan))
        nodes.append(from: `operator`)
        nodes.append(.number(.four))
        nodes.append(.number(.five))
        let result = try tanCommand.execute(node: `operator`)
        XCTAssertEqual(result.head.key.text, "tan")
        XCTAssertEqual(result.tail.key.text, "5")
        XCTAssertEqual(result.newKeys.text, "1")
    }

    func testScientificCalculatorTrigonometricCommand_TanInvalidTail_ThrowException() throws {
        let nodes = CalculatorKeyList()
        let `operator` = CalculatorKeyNode(key: .function(.tan))
        nodes.append(from: `operator`)
        nodes.append(.number(.two))
        nodes.append(.number(.seven))
        nodes.append(.number(.zero))
        XCTAssertThrowsError(try tanCommand.execute(node: `operator`)) { error in
            XCTAssertEqual(error as? CalculatorCommandError, .invalidTail)
        }
    }
}
