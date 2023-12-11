//
//  ScientificCalculatorTrigonometricCommandTests.swift
//  ScientificCalculatorTests
//
//  Created by Jacky Lam on 2023-11-22.
//

import XCTest
@testable import ScientificCalculator_iOS

final class ScientificCalculatorTrigonometricCommandTests: XCTestCase {
    let sinCommand: CalculatorCommand = ScientificCalculatorSinCommand()
    let cosCommand: CalculatorCommand = ScientificCalculatorCosCommand()
    let tanCommand: CalculatorCommand = ScientificCalculatorTanCommand()

    override func setUpWithError() throws {

    }

    override func tearDownWithError() throws {

    }

    func testScientificCalculatorTrigonometricCommand_SinDegree_Execute() throws {
        let nodes = CalculatorKeyList()
        let `operator` = CalculatorKeyNode(key: .function(.sin))
        nodes.append(from: `operator`)
        nodes.append(.number(.three))
        nodes.append(.number(.zero))
        let result = try sinCommand.execute(node: `operator`, params: [.angle: CalculatorAngle.degree])
        XCTAssertEqual(result.head.key.text, "sin")
        XCTAssertEqual(result.tail.key.text, "0")
        XCTAssertEqual(result.newKeys.text, "0.5")
    }

    func testScientificCalculatorTrigonometricCommand_SinRadian_Execute() throws {
        let nodes = CalculatorKeyList()
        let `operator` = CalculatorKeyNode(key: .function(.sin))
        nodes.append(from: `operator`)
        nodes.append(.number(.three))
        nodes.append(.number(.zero))
        let result = try sinCommand.execute(node: `operator`, params: [.angle: CalculatorAngle.radian])
        XCTAssertEqual(result.head.key.text, "sin")
        XCTAssertEqual(result.tail.key.text, "0")
        let startIndex = result.newKeys.text.index(result.newKeys.text.startIndex, offsetBy: 0)
        let endIndex = result.newKeys.text.index(result.newKeys.text.startIndex, offsetBy: 5)
        XCTAssertEqual(result.newKeys.text[startIndex...endIndex], "-0.988")
    }

    func testScientificCalculatorTrigonometricCommand_CosDegree_Execute() throws {
        let nodes = CalculatorKeyList()
        let `operator` = CalculatorKeyNode(key: .function(.cos))
        nodes.append(from: `operator`)
        nodes.append(.number(.six))
        nodes.append(.number(.zero))
        let result = try cosCommand.execute(node: `operator`, params: [.angle: CalculatorAngle.degree])
        XCTAssertEqual(result.head.key.text, "cos")
        XCTAssertEqual(result.tail.key.text, "0")
        XCTAssertEqual(result.newKeys.text, "0.5")
    }

    func testScientificCalculatorTrigonometricCommand_CosRadian_Execute() throws {
        let nodes = CalculatorKeyList()
        let `operator` = CalculatorKeyNode(key: .function(.cos))
        nodes.append(from: `operator`)
        nodes.append(.number(.six))
        nodes.append(.number(.zero))
        let result = try cosCommand.execute(node: `operator`, params: [.angle: CalculatorAngle.radian])
        XCTAssertEqual(result.head.key.text, "cos")
        XCTAssertEqual(result.tail.key.text, "0")
        let startIndex = result.newKeys.text.index(result.newKeys.text.startIndex, offsetBy: 0)
        let endIndex = result.newKeys.text.index(result.newKeys.text.startIndex, offsetBy: 5)
        XCTAssertEqual(result.newKeys.text[startIndex...endIndex], "-0.952")
    }

    func testScientificCalculatorTrigonometricCommand_TanDegree_Execute() throws {
        let nodes = CalculatorKeyList()
        let `operator` = CalculatorKeyNode(key: .function(.tan))
        nodes.append(from: `operator`)
        nodes.append(.number(.four))
        nodes.append(.number(.five))
        let result = try tanCommand.execute(node: `operator`, params: [.angle: CalculatorAngle.degree])
        XCTAssertEqual(result.head.key.text, "tan")
        XCTAssertEqual(result.tail.key.text, "5")
        XCTAssertEqual(result.newKeys.text, "1")
    }

    func testScientificCalculatorTrigonometricCommand_TanRadian_Execute() throws {
        let nodes = CalculatorKeyList()
        let `operator` = CalculatorKeyNode(key: .function(.tan))
        nodes.append(from: `operator`)
        nodes.append(.number(.four))
        nodes.append(.number(.five))
        let result = try tanCommand.execute(node: `operator`, params: [.angle: CalculatorAngle.radian])
        XCTAssertEqual(result.head.key.text, "tan")
        XCTAssertEqual(result.tail.key.text, "5")
        let startIndex = result.newKeys.text.index(result.newKeys.text.startIndex, offsetBy: 0)
        let endIndex = result.newKeys.text.index(result.newKeys.text.startIndex, offsetBy: 4)
        XCTAssertEqual(result.newKeys.text[startIndex...endIndex], "1.619")
    }

    func testScientificCalculatorTrigonometricCommand_TanInvalidTail_ThrowMathError() throws {
        let nodes = CalculatorKeyList()
        let `operator` = CalculatorKeyNode(key: .function(.tan))
        nodes.append(from: `operator`)
        nodes.append(.number(.two))
        nodes.append(.number(.seven))
        nodes.append(.number(.zero))
        XCTAssertThrowsError(try tanCommand.execute(node: `operator`, params: [:])) { error in
            XCTAssertEqual(error as? CalculatorError, .math)
        }
    }
}
