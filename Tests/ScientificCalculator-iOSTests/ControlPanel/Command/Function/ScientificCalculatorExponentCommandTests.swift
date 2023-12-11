//
//  ScientificCalculatorExponentCommandTests.swift
//  
//
//  Created by Jacky Lam on 2023-12-10.
//

import XCTest
@testable import ScientificCalculator_iOS

final class ScientificCalculatorExponentCommandTests: XCTestCase {
    let command: CalculatorCommand = ScientificCalculatorExponentCommand()

    override func setUpWithError() throws {

    }

    override func tearDownWithError() throws {

    }

    func testScientificCalculatorExponentCommand_Execute() throws {
        let nodes = CalculatorKeyList()
        let `operator` = CalculatorKeyNode(key: .function(.exponent))
        nodes.append(.number(.two))
        nodes.append(from: `operator`)
        nodes.append(.number(.three))
        let result = try command.execute(node: `operator`)
        XCTAssertEqual(result.head.key.text, "2")
        XCTAssertEqual(result.tail.key.text, "3")
        XCTAssertEqual(result.newKeys.text, "2000")
    }
}
