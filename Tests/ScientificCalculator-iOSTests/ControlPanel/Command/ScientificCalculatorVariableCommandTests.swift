//
//  File.swift
//  
//
//  Created by Jacky Lam on 2023-11-25.
//

import XCTest
@testable import ScientificCalculator_iOS

fileprivate class ScientificCalculatorTestVariableCommand: ScientificCalculatorVariableCommand {

}

final class ScientificCalculatorVariableCommandTests: XCTestCase {
    let command: CalculatorVariableCommand = ScientificCalculatorTestVariableCommand()

    override func setUpWithError() throws {

    }

    override func tearDownWithError() throws {

    }

    func testScientificCalculatorVariableCommand_Execute() throws {
        let nodes = CalculatorKeyList()
        let node = CalculatorKeyNode(key: .variable(.a))
        nodes.append(from: node)
        let result = try command.execute(node: node, value: 3.0)
        XCTAssertEqual(result.head.key.text, "a")
        XCTAssertEqual(result.tail.key.text, "a")
        XCTAssertEqual(result.newKeys.text, "3")
    }

    func testScientificCalculatorVariableCommand_WithHead_Execute() throws {
        let nodes = CalculatorKeyList()
        let node = CalculatorKeyNode(key: .variable(.a))
        nodes.append(.number(.two))
        nodes.append(from: node)
        let result = try command.execute(node: node, value: 3.0)
        XCTAssertEqual(result.head.key.text, "2")
        XCTAssertEqual(result.tail.key.text, "a")
        XCTAssertEqual(result.newKeys.text, "6")
    }

    func testScientificCalculatorVariableCommand_WithNumberTail_ThrowSyntaxError() throws {
        let nodes = CalculatorKeyList()
        let node = CalculatorKeyNode(key: .variable(.a))
        nodes.append(from: node)
        nodes.append(.number(.two))
        XCTAssertThrowsError(try command.execute(node: node, value: 3.0)) { error in
            XCTAssertEqual(error as? CalculatorError, .syntax)
        }
    }
}
