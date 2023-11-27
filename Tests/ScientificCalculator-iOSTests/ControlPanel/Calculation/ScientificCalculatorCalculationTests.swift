//
//  ScientificCalculatorCalculationTests.swift
//  ScientificCalculatorTests
//
//  Created by Jacky Lam on 2023-11-18.
//

import XCTest
@testable import ScientificCalculator_iOS

final class ScientificCalculatorCalculationTests: XCTestCase {
    let calculation: CalculatorCalculation = ScientificCalculatorCalculation()

    override func setUpWithError() throws {

    }

    override func tearDownWithError() throws {

    }

    func testScientificCalculatorCalculation_Plus_Simplify() throws {
        let nodes = CalculatorKeyList()
        nodes.append(.number(.one))
        nodes.append(.operator(.plus))
        nodes.append(.number(.two))
        nodes.append(.operator(.plus))
        nodes.append(.number(.three))
        nodes.append(.operator(.plus))
        nodes.append(.number(.four))
        XCTAssertEqual(try calculation.simplifyPlusMinus(for: nodes).text, "10")
    }

    func testScientificCalculatorCalculation_Minus_Simplify() throws {
        let nodes = CalculatorKeyList()
        nodes.append(.number(.nine))
        nodes.append(.operator(.minus))
        nodes.append(.number(.one))
        nodes.append(.operator(.minus))
        nodes.append(.number(.two))
        nodes.append(.operator(.minus))
        nodes.append(.number(.three))
        XCTAssertEqual(try calculation.simplifyPlusMinus(for: nodes).text, "3")
    }

    func testScientificCalculatorCalculation_PlusMinus_Simplify() throws {
        let nodes = CalculatorKeyList()
        nodes.append(.number(.nine))
        nodes.append(.operator(.plus))
        nodes.append(.number(.one))
        nodes.append(.operator(.minus))
        nodes.append(.number(.two))
        nodes.append(.operator(.plus))
        nodes.append(.number(.three))
        nodes.append(.operator(.minus))
        nodes.append(.number(.four))
        XCTAssertEqual(try calculation.simplifyPlusMinus(for: nodes).text, "7")
    }

    func testScientificCalculatorCalculation_Multiply_Simplify() throws {
        let nodes = CalculatorKeyList()
        nodes.append(.number(.one))
        nodes.append(.operator(.multiply))
        nodes.append(.number(.two))
        nodes.append(.operator(.multiply))
        nodes.append(.number(.three))
        nodes.append(.operator(.multiply))
        nodes.append(.number(.four))
        XCTAssertEqual(try calculation.simplifyMultiplyDivide(for: nodes).text, "24")
    }

    func testScientificCalculatorCalculation_Divide_Simplify() throws {
        let nodes = CalculatorKeyList()
        nodes.append(.number(.two))
        nodes.append(.number(.four))
        nodes.append(.operator(.divide))
        nodes.append(.number(.four))
        nodes.append(.operator(.divide))
        nodes.append(.number(.three))
        nodes.append(.operator(.divide))
        nodes.append(.number(.two))
        XCTAssertEqual(try calculation.simplifyMultiplyDivide(for: nodes).text, "1")
    }

    func testScientificCalculatorCalculation_MultiplyDivide_Simplify() throws {
        let nodes = CalculatorKeyList()
        nodes.append(.number(.one))
        nodes.append(.operator(.plus))
        nodes.append(.number(.nine))
        nodes.append(.operator(.multiply))
        nodes.append(.number(.eight))
        nodes.append(.operator(.divide))
        nodes.append(.number(.six))
        nodes.append(.operator(.multiply))
        nodes.append(.number(.three))
        nodes.append(.operator(.divide))
        nodes.append(.number(.nine))
        XCTAssertEqual(try calculation.simplifyMultiplyDivide(for: nodes).text, "1+4")
    }

    func testScientificCalculatorCalculation_Function_Simplify() throws {
        let nodes = CalculatorKeyList()
        nodes.append(.number(.four))
        nodes.append(.function(.factorial))
        XCTAssertEqual(try calculation.simplifyFunction(for: nodes).text, "24")
    }

    func testScientificCalculatorCalculation_WithVariable_Simplify() throws {
        let nodes = CalculatorKeyList()
        nodes.append(.variable(.a))
        XCTAssertEqual(try calculation.simplifyVariable(for: nodes, with: [.a: 1]).text, "1")
    }

    func testScientificCalculatorCalculation_WithoutVariable_Simplify() throws {
        let nodes = CalculatorKeyList()
        nodes.append(.variable(.a))
        XCTAssertEqual(try calculation.simplifyVariable(for: nodes, with: [:]).text, "0")
    }

    func testScientificCalculatorCalculation_BracketNotClose_ThrowException() throws {
        let nodes = CalculatorKeyList()
        nodes.append(.bracket(.openBracket))
        nodes.append(.number(.one))
        nodes.append(.operator(.plus))
        nodes.append(.number(.two))
        XCTAssertThrowsError(try calculation.simplifyBracket(for: nodes, with: [:])) { error in
            XCTAssertEqual(error as? CalculatorPairCommandError, .invalidOpen)
        }
    }

    func testScientificCalculatorCalculation_BracketNotOpenBeforeClose_ThrowException() throws {
        let nodes = CalculatorKeyList()
        nodes.append(.bracket(.closeBracket))
        XCTAssertThrowsError(try calculation.simplifyBracket(for: nodes, with: [:])) { error in
            XCTAssertEqual(error as? CalculatorPairCommandError, .invalidClose)
        }
    }

    func testScientificCalculatorCalculation_Bracket_Simplify() throws {
        let nodes = CalculatorKeyList()
        nodes.append(.number(.two))
        nodes.append(.bracket(.openBracket))
        nodes.append(.bracket(.openBracket))
        nodes.append(.number(.one))
        nodes.append(.operator(.plus))
        nodes.append(.number(.two))
        nodes.append(.bracket(.closeBracket))
        nodes.append(.operator(.multiply))
        nodes.append(.number(.three))
        nodes.append(.bracket(.closeBracket))
        nodes.append(.function(.sin))
        nodes.append(.number(.three))
        nodes.append(.number(.zero))
        XCTAssertEqual(try calculation.simplifyBracket(for: nodes, with: [:]).text, "2x9sin30")
    }

    func testScientificCalculatorCalculation_WithoutBracket_Calculate() throws {
        let nodes = CalculatorKeyList()
        nodes.append(.number(.one))
        nodes.append(.operator(.plus))
        nodes.append(.number(.two))
        nodes.append(.operator(.multiply))
        nodes.append(.number(.three))
        nodes.append(.function(.sin))
        nodes.append(.number(.three))
        nodes.append(.number(.zero))
        XCTAssertEqual(try calculation.calculate(for: nodes, with: [:]), 4)
    }

    func testScientificCalculatorCalculation_WithBracket_Calculate() throws {
        let nodes = CalculatorKeyList()
        nodes.append(.number(.two))
        nodes.append(.bracket(.openBracket))
        nodes.append(.bracket(.openBracket))
        nodes.append(.number(.one))
        nodes.append(.operator(.plus))
        nodes.append(.number(.two))
        nodes.append(.bracket(.closeBracket))
        nodes.append(.operator(.multiply))
        nodes.append(.number(.three))
        nodes.append(.bracket(.closeBracket))
        nodes.append(.function(.sin))
        nodes.append(.number(.three))
        nodes.append(.number(.zero))
        XCTAssertEqual(try calculation.calculate(for: nodes, with: [:]), 9)
    }
}
