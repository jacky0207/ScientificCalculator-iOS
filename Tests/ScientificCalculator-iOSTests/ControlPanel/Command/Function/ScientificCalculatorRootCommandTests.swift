//
//  ScientificCalculatorRootCommandTests.swift
//  
//
//  Created by Jacky Lam on 2023-11-23.
//

import XCTest
@testable import ScientificCalculator_iOS

final class ScientificCalculatorRootCommandTests: XCTestCase {
    let rootCommand: CalculatorCommand = ScientificCalculatorRootCommand()
    let squareCommand: CalculatorCommand = ScientificCalculatorSquareRootCommand()
    let cubeCommand: CalculatorCommand = ScientificCalculatorCubeRootCommand()

    override func setUpWithError() throws {

    }

    override func tearDownWithError() throws {

    }

    func testScientificCalculatorRootCommand_Root_Execute() throws {
        let nodes = CalculatorKeyList()
        let `operator` = CalculatorKeyNode(key: .function(.root))
        nodes.append(.number(.two))
        nodes.append(from: `operator`)
        nodes.append(.number(.nine))
        let result = try rootCommand.execute(node: `operator`)
        XCTAssertEqual(result.head.key.text, "2")
        XCTAssertEqual(result.tail.key.text, "9")
        XCTAssertEqual(result.newKeys.text, "3")
    }

    func testScientificCalculatorRootCommand_SquareRoot_Execute() throws {
        let nodes = CalculatorKeyList()
        let `operator` = CalculatorKeyNode(key: .function(.squareRoot))
        nodes.append(.number(.two))
        nodes.append(from: `operator`)
        nodes.append(.number(.nine))
        let result = try squareCommand.execute(node: `operator`)
        XCTAssertEqual(result.head.key.text, "2")
        XCTAssertEqual(result.tail.key.text, "9")
        XCTAssertEqual(result.newKeys.text, "6")
    }

    func testScientificCalculatorRootCommand_CubeRoot_Execute() throws {
        let nodes = CalculatorKeyList()
        let `operator` = CalculatorKeyNode(key: .function(.cubeRoot))
        nodes.append(.number(.two))
        nodes.append(from: `operator`)
        nodes.append(.number(.two))
        nodes.append(.number(.seven))
        let result = try cubeCommand.execute(node: `operator`)
        XCTAssertEqual(result.head.key.text, "2")
        XCTAssertEqual(result.tail.key.text, "7")
        XCTAssertEqual(result.newKeys.text, "6")
    }
}
