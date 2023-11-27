//
//  ScientificCalculatorProgramExecutorTests.swift
//  
//
//  Created by Jacky Lam on 2023-11-26.
//

import XCTest
@testable import ScientificCalculator_iOS

final class ScientificCalculatorProgramExecutorTests: XCTestCase {
    let executor: CalculatorProgramExecutor = ScientificCalculatorProgramExecutor()

    override func setUpWithError() throws {
        executor.setEquations(for: ScientificCalculatorProgram.none)
    }

    override func tearDownWithError() throws {

    }

    func testScientificCalculatorProgramExecutor_HasNextEquation() {
        XCTAssertFalse(executor.hasNextEquation())
        executor.setEquations(for: ScientificCalculatorProgram(
            name: "Title",
            equations: [
                ScientificCalculatorProgramEquation(variable: .a, keys: CalculatorKeyList())
            ],
            subEquations: []
        ))
        XCTAssertTrue(executor.hasNextEquation())
    }

    func testScientificCalculatorProgramExecutor_NextEquation() {
        XCTAssertFalse(executor.hasNextEquation())
        executor.setEquations(for: ScientificCalculatorProgram(
            name: "Title",
            equations: [
                ScientificCalculatorProgramEquation(variable: .a, keys: CalculatorKeyList())
            ],
            subEquations: []
        ))
        XCTAssertEqual(executor.nextEquation().variable, .a)
    }

    func testScientificCalculatorProgramExecutor_SetEquations() {
        executor.setEquations(for: ScientificCalculatorProgram(
            name: "Title",
            equations: [
                ScientificCalculatorProgramEquation(variable: .c, keys: CalculatorKeyList()),
                ScientificCalculatorProgramEquation(variable: .d, keys: CalculatorKeyList()),
            ],
            subEquations: [
                ScientificCalculatorProgramSubEquation(variable: .a, type: .input),
                ScientificCalculatorProgramSubEquation(variable: .b, type: .input),
            ]
        ))
        XCTAssertEqual(executor.nextEquation().variable, .a)
        XCTAssertEqual(executor.nextEquation().variable, .b)
        XCTAssertEqual(executor.nextEquation().variable, .c)
        XCTAssertEqual(executor.nextEquation().variable, .d)
    }
}
