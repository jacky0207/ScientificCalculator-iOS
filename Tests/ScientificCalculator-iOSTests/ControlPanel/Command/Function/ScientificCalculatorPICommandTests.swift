//
//  ScientificCalculatorPICommandTests.swift
//  
//
//  Created by Jacky Lam on 2023-12-10.
//

import XCTest
@testable import ScientificCalculator_iOS

final class ScientificCalculatorPICommandTests: XCTestCase {
    let factorialCommand: CalculatorCommand = ScientificCalculatorPICommand()

    override func setUpWithError() throws {

    }

    override func tearDownWithError() throws {

    }

    func testScientificCalculatorPICommand_Execute() throws {
        let nodes = CalculatorKeyList()
        let `operator` = CalculatorKeyNode(key: .function(.pi))
        nodes.append(.number(.two))
        nodes.append(from: `operator`)
        let result = try factorialCommand.execute(node: `operator`, params: [:])
        XCTAssertEqual(result.head.key.text, "2")
        XCTAssertEqual(result.tail.key.text, "π")
        XCTAssertEqual(result.newKeys.text, "\(2 * Double.pi)")
    }
}
