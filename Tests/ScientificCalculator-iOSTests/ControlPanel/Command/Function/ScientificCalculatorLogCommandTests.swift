//
//  ScientificCalculatorLogCommandTests.swift
//  ScientificCalculatorTests
//
//  Created by Jacky Lam on 2023-11-22.
//

import XCTest
@testable import ScientificCalculator_iOS

final class ScientificCalculatorLogCommandTests: XCTestCase {
    let logCommand: CalculatorCommand = ScientificCalculatorLogCommand()
    let naturalLogCommand: CalculatorCommand = ScientificCalculatorNaturalLogCommand()

    override func setUpWithError() throws {

    }

    override func tearDownWithError() throws {

    }

    func testScientificCalculatorLogCommand_Log_Execute() throws {
        let nodes = CalculatorKeyList()
        let `operator` = CalculatorKeyNode(key: .function(.log))
        nodes.append(from: `operator`)
        nodes.append(.number(.one))
        nodes.append(.number(.zero))
        let result = try logCommand.execute(node: `operator`, params: [:])
        XCTAssertEqual(result.head.key.text, "log")
        XCTAssertEqual(result.tail.key.text, "0")
        XCTAssertEqual(result.newKeys.text, "1")
    }

    func testScientificCalculatorLogCommand_NaturalLog_Execute() throws {
        let nodes = CalculatorKeyList()
        let `operator` = CalculatorKeyNode(key: .function(.naturalLog))
        nodes.append(from: `operator`)
        nodes.append(.number(.four))
        let result = try naturalLogCommand.execute(node: `operator`, params: [:])
        XCTAssertEqual(result.head.key.text, "ln")
        XCTAssertEqual(result.tail.key.text, "4")
        let startIndex = result.newKeys.text.index(result.newKeys.text.startIndex, offsetBy: 0)
        let endIndex = result.newKeys.text.index(result.newKeys.text.startIndex, offsetBy: 4)
        XCTAssertEqual(result.newKeys.text[startIndex...endIndex], "1.386")
    }
}
