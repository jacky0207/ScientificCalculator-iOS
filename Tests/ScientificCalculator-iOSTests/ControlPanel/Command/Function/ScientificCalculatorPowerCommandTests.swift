//
//  ScientificCalculatorPowerCommandTests.swift
//  ScientificCalculatorTests
//
//  Created by Jacky Lam on 2023-11-20.
//

import XCTest
@testable import ScientificCalculator_iOS

final class ScientificCalculatorPowerCommandTests: XCTestCase {
    let powerCommand: CalculatorCommand = ScientificCalculatorPowerCommand()
    let inverseFractionCommand: CalculatorCommand = ScientificCalculatorInverseFractionCommand()
    let squareCommand: CalculatorCommand = ScientificCalculatorSquareCommand()
    let cubeCommand: CalculatorCommand = ScientificCalculatorCubeCommand()

    override func setUpWithError() throws {

    }

    override func tearDownWithError() throws {

    }

    func testScientificCalculatorPowerCommand_Power_Execute() throws {
        let nodes = CalculatorKeyList()
        let `operator` = CalculatorKeyNode(key: .function(.power))
        nodes.append(.number(.two))
        nodes.append(from: `operator`)
        nodes.append(.number(.four))
        let result = try powerCommand.execute(node: `operator`, params: [:])
        XCTAssertEqual(result.head.key.text, "2")
        XCTAssertEqual(result.tail.key.text, "4")
        XCTAssertEqual(result.newKeys.text, "16")
    }

    func testScientificCalculatorPowerCommand_InverseFraction_Execute() throws {
        let nodes = CalculatorKeyList()
        let `operator` = CalculatorKeyNode(key: .function(.inverseFraction))
        nodes.append(.number(.two))
        nodes.append(from: `operator`)
        let result = try inverseFractionCommand.execute(node: `operator`, params: [:])
        XCTAssertEqual(result.head.key.text, "2")
        XCTAssertEqual(result.tail.key.text, "\u{207B}\u{00B9}")
        XCTAssertEqual(result.newKeys.text, "0.5")
    }

    func testScientificCalculatorPowerCommand_InverseFractionNumberTail_ThrowSyntaxError() throws {
        let nodes = CalculatorKeyList()
        let `operator` = CalculatorKeyNode(key: .function(.inverseFraction))
        nodes.append(.number(.two))
        nodes.append(from: `operator`)
        nodes.append(.number(.two))
        XCTAssertThrowsError(try inverseFractionCommand.execute(node: `operator`, params: [:])) { error in
            XCTAssertEqual(error as? CalculatorError, .syntax)
        }
    }

    func testScientificCalculatorPowerCommand_Square_Execute() throws {
        let nodes = CalculatorKeyList()
        let `operator` = CalculatorKeyNode(key: .function(.square))
        nodes.append(.number(.three))
        nodes.append(from: `operator`)
        let result = try squareCommand.execute(node: `operator`, params: [:])
        XCTAssertEqual(result.head.key.text, "3")
        XCTAssertEqual(result.tail.key.text, "\u{00B2}")
        XCTAssertEqual(result.newKeys.text, "9")
    }

    func testScientificCalculatorPowerCommand_SquareNumberTail_ThrowSyntaxError() throws {
        let nodes = CalculatorKeyList()
        let `operator` = CalculatorKeyNode(key: .function(.square))
        nodes.append(.number(.three))
        nodes.append(from: `operator`)
        nodes.append(.number(.three))
        XCTAssertThrowsError(try squareCommand.execute(node: `operator`, params: [:])) { error in
            XCTAssertEqual(error as? CalculatorError, .syntax)
        }
    }

    func testScientificCalculatorPowerCommand_Cube_Execute() throws {
        let nodes = CalculatorKeyList()
        let `operator` = CalculatorKeyNode(key: .function(.cube))
        nodes.append(.number(.three))
        nodes.append(from: `operator`)
        let result = try cubeCommand.execute(node: `operator`, params: [:])
        XCTAssertEqual(result.head.key.text, "3")
        XCTAssertEqual(result.tail.key.text, "\u{00B3}")
        XCTAssertEqual(result.newKeys.text, "27")
    }

    func testScientificCalculatorPowerCommand_CubeNumberTail_ThrowSyntaxError() throws {
        let nodes = CalculatorKeyList()
        let `operator` = CalculatorKeyNode(key: .function(.cube))
        nodes.append(.number(.three))
        nodes.append(from: `operator`)
        nodes.append(.number(.three))
        XCTAssertThrowsError(try cubeCommand.execute(node: `operator`, params: [:])) { error in
            XCTAssertEqual(error as? CalculatorError, .syntax)
        }
    }
}
