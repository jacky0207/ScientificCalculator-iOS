//
//  ScientificCalculatorOperatorCommandTests.swift
//  ScientificCalculatorTests
//
//  Created by Jacky Lam on 2023-11-22.
//

import XCTest
@testable import ScientificCalculator_iOS

final class ScientificCalculatorOperatorCommandTests: XCTestCase {
    let plusCommand: CalculatorCommand = ScientificCalculatorPlusCommand()
    let minusCommand: CalculatorCommand = ScientificCalculatorMinusCommand()
    let multiplyCommand: CalculatorCommand = ScientificCalculatorMultiplyCommand()
    let divideCommand: CalculatorCommand = ScientificCalculatorDivideCommand()

    override func setUpWithError() throws {

    }

    override func tearDownWithError() throws {

    }

    func testScientificCalculatorOperatorCommand_Plus_Execute() throws {
        let nodes = CalculatorKeyList()
        let `operator` = CalculatorKeyNode(key: .operator(.plus))
        nodes.append(.number(.one))
        nodes.append(from: `operator`)
        nodes.append(.number(.two))
        let result = try plusCommand.execute(node: `operator`)
        XCTAssertEqual(result.head.key.text, "1")
        XCTAssertEqual(result.tail.key.text, "2")
        XCTAssertEqual(result.newKeys.text, "3")
    }

    func testScientificCalculatorOperatorCommand_SignedPositive_Execute() throws {
        let nodes = CalculatorKeyList()
        let `operator` = CalculatorKeyNode(key: .operator(.plus))
        nodes.append(from: `operator`)
        nodes.append(.number(.two))
        let result = try plusCommand.execute(node: `operator`)
        XCTAssertEqual(result.head.key.text, "+")
        XCTAssertEqual(result.tail.key.text, "+")
        XCTAssertEqual(result.newKeys.text, "+")
    }

    func testScientificCalculatorOperatorCommand_Minus_Execute() throws {
        let nodes = CalculatorKeyList()
        let `operator` = CalculatorKeyNode(key: .operator(.minus))
        nodes.append(.number(.two))
        nodes.append(from: `operator`)
        nodes.append(.number(.one))
        let result = try minusCommand.execute(node: `operator`)
        XCTAssertEqual(result.head.key.text, "2")
        XCTAssertEqual(result.tail.key.text, "1")
        XCTAssertEqual(result.newKeys.text, "1")
    }

    func testScientificCalculatorOperatorCommand_SignedNegative_Execute() throws {
        let nodes = CalculatorKeyList()
        let `operator` = CalculatorKeyNode(key: .operator(.minus))
        nodes.append(from: `operator`)
        nodes.append(.number(.two))
        let result = try minusCommand.execute(node: `operator`)
        XCTAssertEqual(result.head.key.text, "-")
        XCTAssertEqual(result.tail.key.text, "-")
        XCTAssertEqual(result.newKeys.text, "-")
    }

    func testScientificCalculatorOperatorCommand_Multliply_Execute() throws {
        let nodes = CalculatorKeyList()
        let `operator` = CalculatorKeyNode(key: .operator(.multiply))
        nodes.append(.number(.two))
        nodes.append(from: `operator`)
        nodes.append(.number(.three))
        let result = try multiplyCommand.execute(node: `operator`)
        XCTAssertEqual(result.head.key.text, "2")
        XCTAssertEqual(result.tail.key.text, "3")
        XCTAssertEqual(result.newKeys.text, "6")
    }

    func testScientificCalculatorOperatorCommand_Divide_Execute() throws {
        let nodes = CalculatorKeyList()
        let `operator` = CalculatorKeyNode(key: .operator(.divide))
        nodes.append(.number(.six))
        nodes.append(from: `operator`)
        nodes.append(.number(.two))
        let result = try divideCommand.execute(node: `operator`)
        XCTAssertEqual(result.head.key.text, "6")
        XCTAssertEqual(result.tail.key.text, "2")
        XCTAssertEqual(result.newKeys.text, "3")
    }
}
