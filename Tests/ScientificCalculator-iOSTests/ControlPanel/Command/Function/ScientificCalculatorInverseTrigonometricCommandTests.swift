//
//  ScientificCalculatorInverseTrigonometricCommandTests.swift
//  
//
//  Created by Jacky Lam on 2023-11-27.
//

import XCTest
@testable import ScientificCalculator_iOS

final class ScientificCalculatorInverseTrigonometricCommandTests: XCTestCase {
    let inverseSinCommand: CalculatorCommand = ScientificCalculatorInverseSinCommand()
    let inverseCosCommand: CalculatorCommand = ScientificCalculatorInverseCosCommand()
    let inverseTanCommand: CalculatorCommand = ScientificCalculatorInverseTanCommand()

    override func setUpWithError() throws {

    }

    override func tearDownWithError() throws {

    }

    func testScientificCalculatorTrigonometricCommand_InverseSinDegree_Execute() throws {
        let nodes = CalculatorKeyList()
        let `operator` = CalculatorKeyNode(key: .function(.inverseSin))
        nodes.append(from: `operator`)
        nodes.append(.number(.zero))
        nodes.append(.number(.dot))
        nodes.append(.number(.five))
        let result = try inverseSinCommand.execute(node: `operator`, params: [.angle: CalculatorAngle.degree])
        XCTAssertEqual(result.head.key.text, "sin\u{207B}\u{00B9}")
        XCTAssertEqual(result.tail.key.text, "5")
        XCTAssertEqual(result.newKeys.text, "30")
    }

    func testScientificCalculatorTrigonometricCommand_InverseSinRadian_Execute() throws {
        let nodes = CalculatorKeyList()
        let `operator` = CalculatorKeyNode(key: .function(.inverseSin))
        nodes.append(from: `operator`)
        nodes.append(.number(.zero))
        nodes.append(.number(.dot))
        nodes.append(.number(.five))
        let result = try inverseSinCommand.execute(node: `operator`, params: [.angle: CalculatorAngle.radian])
        XCTAssertEqual(result.head.key.text, "sin\u{207B}\u{00B9}")
        XCTAssertEqual(result.tail.key.text, "5")
        let startIndex = result.newKeys.text.index(result.newKeys.text.startIndex, offsetBy: 0)
        let endIndex = result.newKeys.text.index(result.newKeys.text.startIndex, offsetBy: 4)
        XCTAssertEqual(result.newKeys.text[startIndex...endIndex], "0.523")
    }

    func testScientificCalculatorTrigonometricCommand_InverseCosDegree_Execute() throws {
        let nodes = CalculatorKeyList()
        let `operator` = CalculatorKeyNode(key: .function(.inverseCos))
        nodes.append(from: `operator`)
        nodes.append(.number(.zero))
        nodes.append(.number(.dot))
        nodes.append(.number(.five))
        let result = try inverseCosCommand.execute(node: `operator`, params: [.angle: CalculatorAngle.degree])
        XCTAssertEqual(result.head.key.text, "cos\u{207B}\u{00B9}")
        XCTAssertEqual(result.tail.key.text, "5")
        XCTAssertEqual(result.newKeys.text, "60")
    }

    func testScientificCalculatorTrigonometricCommand_InverseCosRadian_Execute() throws {
        let nodes = CalculatorKeyList()
        let `operator` = CalculatorKeyNode(key: .function(.inverseCos))
        nodes.append(from: `operator`)
        nodes.append(.number(.zero))
        nodes.append(.number(.dot))
        nodes.append(.number(.five))
        let result = try inverseCosCommand.execute(node: `operator`, params: [.angle: CalculatorAngle.radian])
        XCTAssertEqual(result.head.key.text, "cos\u{207B}\u{00B9}")
        XCTAssertEqual(result.tail.key.text, "5")
        let startIndex = result.newKeys.text.index(result.newKeys.text.startIndex, offsetBy: 0)
        let endIndex = result.newKeys.text.index(result.newKeys.text.startIndex, offsetBy: 4)
        XCTAssertEqual(result.newKeys.text[startIndex...endIndex], "1.047")
    }

    func testScientificCalculatorTrigonometricCommand_InverseTanDegree_Execute() throws {
        let nodes = CalculatorKeyList()
        let `operator` = CalculatorKeyNode(key: .function(.inverseTan))
        nodes.append(from: `operator`)
        nodes.append(.number(.one))
        let result = try inverseTanCommand.execute(node: `operator`, params: [.angle: CalculatorAngle.degree])
        XCTAssertEqual(result.head.key.text, "tan\u{207B}\u{00B9}")
        XCTAssertEqual(result.tail.key.text, "1")
        XCTAssertEqual(result.newKeys.text, "45")
    }

    func testScientificCalculatorTrigonometricCommand_InverseTanRadian_Execute() throws {
        let nodes = CalculatorKeyList()
        let `operator` = CalculatorKeyNode(key: .function(.inverseTan))
        nodes.append(from: `operator`)
        nodes.append(.number(.one))
        let result = try inverseTanCommand.execute(node: `operator`, params: [.angle: CalculatorAngle.radian])
        XCTAssertEqual(result.head.key.text, "tan\u{207B}\u{00B9}")
        XCTAssertEqual(result.tail.key.text, "1")
        let startIndex = result.newKeys.text.index(result.newKeys.text.startIndex, offsetBy: 0)
        let endIndex = result.newKeys.text.index(result.newKeys.text.startIndex, offsetBy: 4)
        XCTAssertEqual(result.newKeys.text[startIndex...endIndex], "0.785")
    }
}
