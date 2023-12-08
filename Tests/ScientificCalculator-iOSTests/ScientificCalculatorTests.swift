//
//  ScientificCalculatorTests.swift
//  ScientificCalculatorTests
//
//  Created by Jacky Lam on 2023-11-17.
//

import XCTest
@testable import ScientificCalculator_iOS

final class ScientificCalculatorTests: XCTestCase {
    let calculator: any Calculator = ScientificCalculator()

    override func setUpWithError() throws {
        
    }

    override func tearDownWithError() throws {
        
    }

    func testScientificCalculator_AppendKey() throws {
        calculator.appendKey(.number(.one))
        XCTAssertEqual(calculator.text, "1")
    }

    func testScientificCalculator_SetKeys() throws {
        let keys = CalculatorKeyList()
        keys.append(.number(.one))
        keys.append(.operator(.plus))
        keys.append(.number(.two))
        calculator.setKeys(keys)
        XCTAssertEqual(calculator.text, "1+2")
    }

    func testScientificCalculator_Delete() throws {
        calculator.appendKey(.number(.one))
        calculator.appendKey(.number(.two))
        calculator.delete()
        XCTAssertEqual(calculator.text, "1")
    }

    func testScientificCalculator_ClearAll() throws {
        calculator.appendKey(.number(.one))
        calculator.appendKey(.number(.two))
        try calculator.calculate()
        calculator.clearAll()
        XCTAssertEqual(calculator.text, "")
        XCTAssertEqual(calculator.answer, 0)
    }

    func testScientificCalculator_Calculate() throws {
        calculator.appendKey(.number(.two))
        calculator.appendKey(.bracket(.openBracket))
        calculator.appendKey(.bracket(.openBracket))
        calculator.appendKey(.number(.one))
        calculator.appendKey(.operator(.plus))
        calculator.appendKey(.number(.two))
        calculator.appendKey(.bracket(.closeBracket))
        calculator.appendKey(.operator(.multiply))
        calculator.appendKey(.number(.three))
        calculator.appendKey(.bracket(.closeBracket))
        calculator.appendKey(.function(.sin))
        calculator.appendKey(.number(.three))
        calculator.appendKey(.number(.zero))
        try calculator.calculate()
        XCTAssertEqual(calculator.answer, 9)
    }

    func testScientificCalculator_CalculateToVariable() throws {
        calculator.appendKey(.number(.two))
        calculator.appendKey(.bracket(.openBracket))
        calculator.appendKey(.bracket(.openBracket))
        calculator.appendKey(.number(.one))
        calculator.appendKey(.operator(.plus))
        calculator.appendKey(.number(.two))
        calculator.appendKey(.bracket(.closeBracket))
        calculator.appendKey(.operator(.multiply))
        calculator.appendKey(.number(.three))
        calculator.appendKey(.bracket(.closeBracket))
        calculator.appendKey(.function(.sin))
        calculator.appendKey(.number(.three))
        calculator.appendKey(.number(.zero))
        try calculator.calculate(to: .a)
        XCTAssertEqual(calculator.answer, 9)
        XCTAssertEqual(calculator.storage.values[.a], 9)
    }

    func testScientificCalculator_ExecuteProgram() throws {
        let program = ScientificCalculatorProgram(
            name: "",
            equations: [
                ScientificCalculatorProgramEquation(
                    variable: .x,
                    keys: CalculatorKeyList(
                        .bracket(.openBracket),
                        .operator(.minus),
                        .variable(.b),
                        .operator(.plus),
                        .function(.squareRoot),
                        .variable(.d),
                        .bracket(.closeBracket),
                        .operator(.divide),
                        .number(.two),
                        .variable(.a)
                    )
                ),
                ScientificCalculatorProgramEquation(
                    variable: .y,
                    keys: CalculatorKeyList(
                        .bracket(.openBracket),
                        .operator(.minus),
                        .variable(.b),
                        .operator(.minus),
                        .function(.squareRoot),
                        .variable(.d),
                        .bracket(.closeBracket),
                        .operator(.divide),
                        .number(.two),
                        .variable(.a)
                    )
                ),
            ],
            subEquations: [
                ScientificCalculatorProgramSubEquation(
                    variable: .a,
                    type: .input
                ),
                ScientificCalculatorProgramSubEquation(
                    variable: .b,
                    type: .input
                ),
                ScientificCalculatorProgramSubEquation(
                    variable: .c,
                    type: .input
                ),
                ScientificCalculatorProgramSubEquation(
                    variable: .d,
                    type: .fixed(CalculatorKeyList(  // b^2-4ac
                        .variable(.b),
                        .function(.square),
                        .operator(.minus),
                        .number(.four),
                        .variable(.a),
                        .variable(.c)
                    ))
                ),
            ]
        )
        calculator.execute(for: program)
        XCTAssertEqual(calculator.mode, .program)
        // a
        XCTAssertEqual(calculator.text, "")
        calculator.appendKey(.number(.one))
        try calculator.calculate()
        XCTAssertEqual(calculator.storage.values[.a], 1)
        // b
        XCTAssertEqual(calculator.text, "")
        calculator.appendKey(.number(.one))
        calculator.appendKey(.operator(.plus))
        calculator.appendKey(.number(.three))
        try calculator.calculate()
        XCTAssertEqual(calculator.storage.values[.b], 4)
        // c
        XCTAssertEqual(calculator.text, "")
        calculator.appendKey(.number(.two))
        try calculator.calculate()
        XCTAssertEqual(calculator.storage.values[.c], 2)
        // d
        XCTAssertEqual(calculator.text, "b\u{00B2}-4ac")
        try calculator.calculate()
        XCTAssertEqual(calculator.storage.values[.d], 8)
        // x
        XCTAssertEqual(calculator.text, "(-b+\u{221A}d)÷2a")
        try calculator.calculate()
        XCTAssertEqual(floor((calculator.storage.values[.x] ?? 0) * 1000) / 1000, -0.586)
        // y
        XCTAssertEqual(calculator.text, "(-b-\u{221A}d)÷2a")
        try calculator.calculate()
        XCTAssertEqual(floor((calculator.storage.values[.y] ?? 0) * 1000) / 1000, -3.415)
        // finish
        XCTAssertEqual(calculator.mode, .default)
    }

    func testScientificCalculator_ProgramMode_NotCalculateToVariable() throws {
        calculator.execute(for: ScientificCalculatorProgram(
            name: "",
            equations: [ScientificCalculatorProgramEquation(variable: .a, keys: CalculatorKeyList(.number(.one)))],
            subEquations: []
        ))
        XCTAssertEqual(calculator.mode, .program)
        try calculator.calculate(to: .b)
        XCTAssertEqual(calculator.mode, .program)
    }

    func testScientificCalculator_EmptyEquations_NotExecuteProgram() throws {
        calculator.execute(for: ScientificCalculatorProgram.none)
        XCTAssertEqual(calculator.mode, .default)
    }

    func testScientificCalculator_Calculate_AppendLog() throws {
        calculator.appendKey(.number(.one))
        calculator.appendKey(.operator(.plus))
        calculator.appendKey(.number(.two))
        try calculator.calculate()
        let log = calculator.logHistory.logs.last
        XCTAssertEqual(log?.keys.text, "1+2")
        XCTAssertEqual(log?.answer, 3)
    }

    func testScientificCalculator_CalculateToVariable_AppendLog() throws {
        calculator.appendKey(.number(.one))
        calculator.appendKey(.operator(.plus))
        calculator.appendKey(.number(.two))
        try calculator.calculate(to: .a)
        let log = calculator.logHistory.logs.last
        XCTAssertEqual(log?.keys.text, "1+2")
        XCTAssertEqual(log?.answer, 3)
    }

    func testScientificCalculator_Program_AppendLog() throws {
        let program = ScientificCalculatorProgram(
            name: "",
            equations: [
                ScientificCalculatorProgramEquation(
                    variable: .x,
                    keys: CalculatorKeyList(
                        .bracket(.openBracket),
                        .number(.one),
                        .operator(.plus),
                        .variable(.a),
                        .bracket(.closeBracket),
                        .operator(.multiply),
                        .variable(.a),
                        .operator(.divide),
                        .number(.two)
                    )
                ),
            ],
            subEquations: [
                ScientificCalculatorProgramSubEquation(
                    variable: .a,
                    type: .input
                ),
            ]
        )
        calculator.execute(for: program)
        calculator.appendKey(.number(.one))
        calculator.appendKey(.number(.zero))
        // sub-equation
        try calculator.calculate()
        let subEquationLog = calculator.logHistory.logs.last
        XCTAssertEqual(subEquationLog?.keys.text, "10")
        XCTAssertEqual(subEquationLog?.answer, 10)
        // equation
        try calculator.calculate()
        XCTAssertEqual(calculator.mode, .default)
        let equationLog = calculator.logHistory.logs.last
        XCTAssertEqual(equationLog?.keys.text, "(1+a)xa÷2")
        XCTAssertEqual(equationLog?.answer, 55)
    }
}
