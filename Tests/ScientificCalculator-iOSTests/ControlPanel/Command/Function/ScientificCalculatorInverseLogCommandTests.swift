//
//  ScientificCalculatorInverseLogCommandTests.swift
//  
//
//  Created by Jacky Lam on 2023-11-23.
//

import XCTest
@testable import ScientificCalculator_iOS

final class ScientificCalculatorInverseLogCommandTests: XCTestCase {
    let powerOfTenCommand: CalculatorCommand = ScientificCalculatorPowerOfTenCommand()
    let exponentialCommand: CalculatorCommand = ScientificCalculatorExponentialCommand()

    override func setUpWithError() throws {

    }

    override func tearDownWithError() throws {

    }

    func testScientificCalculatorInverseLogCommand_PowerOfTen_Execute() throws {
        let nodes = CalculatorKeyList()
        let `operator` = CalculatorKeyNode(key: .function(.powerOfTen))
        nodes.append(.number(.two))
        nodes.append(from: `operator`)
        nodes.append(.number(.three))
        let result = try powerOfTenCommand.execute(node: `operator`)
        XCTAssertEqual(result.head.key.text, "2")
        XCTAssertEqual(result.tail.key.text, "3")
        XCTAssertEqual(result.newKeys.text, "2000")
    }

    func testScientificCalculatorInverseLogCommand_Exponential_Execute() throws {
        let nodes = CalculatorKeyList()
        let `operator` = CalculatorKeyNode(key: .function(.exponential))
        nodes.append(.number(.two))
        nodes.append(from: `operator`)
        nodes.append(.number(.one))
        let result = try exponentialCommand.execute(node: `operator`)
        XCTAssertEqual(result.head.key.text, "2")
        XCTAssertEqual(result.tail.key.text, "1")
        let startIndex = result.newKeys.text.index(result.newKeys.text.startIndex, offsetBy: 0)
        let endIndex = result.newKeys.text.index(result.newKeys.text.startIndex, offsetBy: 4)
        XCTAssertEqual(result.newKeys.text[startIndex...endIndex], "5.436")
    }
}
