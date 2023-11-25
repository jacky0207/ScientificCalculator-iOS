//
//  ScientificCalculatorPairCommandTests.swift
//  ScientificCalculatorTests
//
//  Created by Jacky Lam on 2023-11-21.
//

import XCTest
@testable import ScientificCalculator_iOS

fileprivate class ScientificCalculatorTestPairCommand: ScientificCalculatorPairCommand {
    
}

final class ScientificCalculatorPairCommandTests: XCTestCase {
    override func setUpWithError() throws {

    }

    override func tearDownWithError() throws {

    }

    func testScientificCalculatorPairCommand_Execute() throws {
        let command = ScientificCalculatorTestPairCommand()
        let nodes = CalculatorKeyList()
        let open = CalculatorKeyNode(key: .function(.openBracket))
        let close = CalculatorKeyNode(key: .function(.closeBracket))
        nodes.append(from: open)
        nodes.append(.number(.one))
        nodes.append(.operator(.plus))
        nodes.append(.number(.two))
        nodes.append(from: close)
        let result = try command.execute(from: open, to: close, convert: { _ in
            return CalculatorKeyList(CalculatorKeyNode(key: .number(.three)))
        })
        XCTAssertEqual(result.head.key.text, "(")
        XCTAssertEqual(result.tail.key.text, ")")
        XCTAssertEqual(result.newKeys.text, "3")
    }

    func testScientificCalculatorPairCommand_WithHead_Execute() throws {
        let command = ScientificCalculatorTestPairCommand()
        let nodes = CalculatorKeyList()
        let open = CalculatorKeyNode(key: .function(.openBracket))
        let close = CalculatorKeyNode(key: .function(.closeBracket))
        nodes.append(.number(.two))
        nodes.append(from: open)
        nodes.append(.number(.one))
        nodes.append(.operator(.plus))
        nodes.append(.number(.two))
        nodes.append(from: close)
        let result = try command.execute(from: open, to: close, convert: { _ in
            return CalculatorKeyList(CalculatorKeyNode(key: .number(.three)))
        })
        XCTAssertEqual(result.head.key.text, "(")
        XCTAssertEqual(result.tail.key.text, ")")
        XCTAssertEqual(result.newKeys.text, "x3")
    }

    func testScientificCalculatorPairCommand_WithNumberTail_ThrowException() throws {
        let command = ScientificCalculatorTestPairCommand()
        let nodes = CalculatorKeyList()
        let open = CalculatorKeyNode(key: .function(.openBracket))
        let close = CalculatorKeyNode(key: .function(.closeBracket))
        nodes.append(from: open)
        nodes.append(.number(.one))
        nodes.append(.operator(.plus))
        nodes.append(.number(.two))
        nodes.append(from: close)
        nodes.append(.number(.two))
        XCTAssertThrowsError(try command.execute(from: open, to: close, convert: { $0 })) { error in
            XCTAssertEqual(error as? CalculatorPairCommandError, .invalidClose)
        }
    }
}
