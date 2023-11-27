//
//  ScientificCalculatorCommandTests.swift
//  ScientificCalculatorTests
//
//  Created by Jacky Lam on 2023-11-20.
//

import XCTest
@testable import ScientificCalculator_iOS

fileprivate class ScientificCalculatorTestCommand: ScientificCalculatorCommand {
    var headType: CalculatorCommandType
    var tailType: CalculatorCommandType

    init(type: CalculatorCommandType) {
        self.headType = type
        self.tailType = type
    }

    init(
        headType: CalculatorCommandType,
        tailType: CalculatorCommandType
    ) {
        self.headType = headType
        self.tailType = tailType
    }

    override func previousNumberType() -> CalculatorCommandType {
        return headType
    }

    override func nextNumberType() -> CalculatorCommandType {
        return tailType
    }

    override func answer(left: Double, right: Double) throws -> Double {
        return left + right
    }
}

final class ScientificCalculatorCommandTests: XCTestCase {
    override func setUpWithError() throws {

    }

    override func tearDownWithError() throws {

    }

    func testScientificCalculatorCommand_Execute() throws {
        let command = ScientificCalculatorTestCommand(
            type: .exist
        )
        let nodes = CalculatorKeyList()
        let `operator` = CalculatorKeyNode(key: .operator(.plus))
        nodes.append(.number(.one))
        nodes.append(from: `operator`)
        nodes.append(.number(.two))
        let result = try command.execute(node: `operator`)
        XCTAssertEqual(result.head.key.text, "1")
        XCTAssertEqual(result.tail.key.text, "2")
        XCTAssertEqual(result.newKeys.text, "3")
    }

    func testScientificCalculatorCommand_CompulsoryHeadNotExist_ThrowException() throws {
        let command = ScientificCalculatorTestCommand(
            type: .exist
        )
        let nodes = CalculatorKeyList()
        let `operator` = CalculatorKeyNode(key: .operator(.plus))
        nodes.append(from: `operator`)
        nodes.append(.number(.two))
        XCTAssertThrowsError(try command.execute(node: `operator`)) { error in
            XCTAssertEqual(error as? CalculatorCommandError, CalculatorCommandError.invalidHead)
        }
    }

    func testScientificCalculatorCommand_CompulsoryTailNotExist_ThrowException() throws {
        let command = ScientificCalculatorTestCommand(
            type: .exist
        )
        let nodes = CalculatorKeyList()
        let `operator` = CalculatorKeyNode(key: .operator(.plus))
        nodes.append(.number(.two))
        nodes.append(from: `operator`)
        XCTAssertThrowsError(try command.execute(node: `operator`)) { error in
            XCTAssertEqual(error as? CalculatorCommandError, CalculatorCommandError.invalidTail)
        }
    }

    func testScientificCalculatorCommand_OptionalHead_Execute() throws {
        let command = ScientificCalculatorTestCommand(
            type: .optional
        )
        let nodes = CalculatorKeyList()
        let `operator` = CalculatorKeyNode(key: .operator(.plus))
        nodes.append(from: `operator`)
        nodes.append(.number(.two))
        let result = try command.execute(node: `operator`)
        XCTAssertEqual(result.head.key.text, "+")
        XCTAssertEqual(result.tail.key.text, "2")
        XCTAssertEqual(result.newKeys.text, "3")
    }

    func testScientificCalculatorCommand_OptionalTail_Execute() throws {
        let command = ScientificCalculatorTestCommand(
            type: .optional
        )
        let nodes = CalculatorKeyList()
        let `operator` = CalculatorKeyNode(key: .operator(.plus))
        nodes.append(.number(.two))
        nodes.append(from: `operator`)
        let result = try command.execute(node: `operator`)
        XCTAssertEqual(result.head.key.text, "2")
        XCTAssertEqual(result.tail.key.text, "+")
        XCTAssertEqual(result.newKeys.text, "3")
    }

    func testScientificCalculatorCommand_NotExistHeadExist_ThrowException() throws {
        let command = ScientificCalculatorTestCommand(
            type: .notExist
        )
        let nodes = CalculatorKeyList()
        let `operator` = CalculatorKeyNode(key: .operator(.plus))
        nodes.append(.number(.two))
        nodes.append(from: `operator`)
        XCTAssertThrowsError(try command.execute(node: `operator`)) { error in
            XCTAssertEqual(error as? CalculatorCommandError, CalculatorCommandError.invalidHead)
        }
    }

    func testScientificCalculatorCommand_NotExistTailExist_ThrowException() throws {
        let command = ScientificCalculatorTestCommand(
            type: .notExist
        )
        let nodes = CalculatorKeyList()
        let `operator` = CalculatorKeyNode(key: .operator(.plus))
        nodes.append(from: `operator`)
        nodes.append(.number(.two))
        XCTAssertThrowsError(try command.execute(node: `operator`)) { error in
            XCTAssertEqual(error as? CalculatorCommandError, CalculatorCommandError.invalidTail)
        }
    }

    func testScientificCalculatorCommand_NotExistTailPlusMinusNumber_Execute() throws {
        let command = ScientificCalculatorTestCommand(
            headType: .exist,
            tailType: .notExist
        )
        let nodes = CalculatorKeyList()
        let `operator` = CalculatorKeyNode(key: .function(.square))
        nodes.append(.number(.two))
        nodes.append(from: `operator`)
        nodes.append(.operator(.plus))
        nodes.append(.number(.three))
        let result = try command.execute(node: `operator`)
        XCTAssertEqual(result.head.key.text, "2")
        XCTAssertEqual(result.tail.key.text, "\u{00B2}")
        XCTAssertEqual(result.newKeys.text, "3")
    }
}
