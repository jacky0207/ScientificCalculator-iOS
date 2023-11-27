//
//  ScientificCalculatorBracketCommand.swift
//  ScientificCalculatorTests
//
//  Created by Jacky Lam on 2023-11-21.
//

import XCTest
@testable import ScientificCalculator_iOS

final class ScientificCalculatorBracketCommandTests: XCTestCase {
    let bracketCommand = ScientificCalculatorBracketCommand()

    override func setUpWithError() throws {

    }

    override func tearDownWithError() throws {

    }

    func testScientificCalculatorBracketCommand_Execute() throws {
        let nodes = CalculatorKeyList()
        let open = CalculatorKeyNode(key: .bracket(.openBracket))
        let close = CalculatorKeyNode(key: .bracket(.closeBracket))
        nodes.append(from: open)
        nodes.append(.number(.one))
        nodes.append(.operator(.plus))
        nodes.append(.number(.two))
        nodes.append(from: close)
        let result = try bracketCommand.execute(from: open, to: close) { _ in
            CalculatorKeyList(CalculatorKeyNode(key: .number(.three)))
        }
        XCTAssertEqual(result.head.key.text, "(")
        XCTAssertEqual(result.tail.key.text, ")")
        XCTAssertEqual(result.newKeys.text, "3")
    }
}
