//
//  ScientificCalculatorAnswerCommandTests.swift
//  
//
//  Created by Jacky Lam on 2023-12-10.
//

import XCTest
@testable import ScientificCalculator_iOS

fileprivate class ScientificCalculatorTestAnswerCommand: ScientificCalculatorAnswerCommand {

}

final class ScientificCalculatorAnswerCommandTests: XCTestCase {
    let command: CalculatorVariableCommand = ScientificCalculatorTestAnswerCommand()

    override func setUpWithError() throws {

    }

    override func tearDownWithError() throws {

    }

    func testScientificCalculatorAnswerCommand_Execute() throws {
        let nodes = CalculatorKeyList()
        let node = CalculatorKeyNode(key: .variable(.answer))
        nodes.append(from: node)
        let result = try command.execute(node: node, value: 3.0)
        XCTAssertEqual(result.head.key.text, "Ans")
        XCTAssertEqual(result.tail.key.text, "Ans")
        XCTAssertEqual(result.newKeys.text, "3")
    }

    func testScientificCalculatorAnswerCommand_WithHead_Execute() throws {
        let nodes = CalculatorKeyList()
        let node = CalculatorKeyNode(key: .variable(.answer))
        nodes.append(.number(.two))
        nodes.append(from: node)
        let result = try command.execute(node: node, value: 3.0)
        XCTAssertEqual(result.head.key.text, "2")
        XCTAssertEqual(result.tail.key.text, "Ans")
        XCTAssertEqual(result.newKeys.text, "6")
    }

    func testScientificCalculatorAnswerCommand_WithNumberTail_ThrowSyntaxError() throws {
        let nodes = CalculatorKeyList()
        let node = CalculatorKeyNode(key: .variable(.answer))
        nodes.append(from: node)
        nodes.append(.number(.two))
        XCTAssertThrowsError(try command.execute(node: node, value: 3.0)) { error in
            XCTAssertEqual(error as? CalculatorError, .syntax)
        }
    }
}
