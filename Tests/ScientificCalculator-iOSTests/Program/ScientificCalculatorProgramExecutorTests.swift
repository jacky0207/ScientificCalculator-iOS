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
            id: 0,
            name: "Title",
            equations: [
                ScientificCalculatorProgramEquation(id: 0, programId: 0, type: .main, variable: .a, keys: CalculatorKeyList())
            ]
        ))
        XCTAssertTrue(executor.hasNextEquation())
    }

    func testScientificCalculatorProgramExecutor_NextEquation() {
        XCTAssertFalse(executor.hasNextEquation())
        executor.setEquations(for: ScientificCalculatorProgram(
            id: 0,
            name: "Title",
            equations: [
                ScientificCalculatorProgramEquation(id: 0, programId: 0, type: .main, variable: .a, keys: CalculatorKeyList())
            ]
        ))
        XCTAssertEqual(executor.nextEquation().variable, .a)
    }

    func testScientificCalculatorProgramExecutor_SetEquations() {
        executor.setEquations(for: ScientificCalculatorProgram(
            id: 0,
            name: "Title",
            equations: [
                ScientificCalculatorProgramEquation(id: 0, programId: 0, type: .main, variable: .c, keys: CalculatorKeyList()),
                ScientificCalculatorProgramEquation(id: 1, programId: 0, type: .main, variable: .d, keys: CalculatorKeyList()),
                ScientificCalculatorProgramEquation(id: 2, programId: 0, type: .sub, variable: .a, keys: CalculatorKeyList()),
                ScientificCalculatorProgramEquation(id: 3, programId: 0, type: .sub, variable: .b, keys: CalculatorKeyList()),
            ]
        ))
        XCTAssertEqual(executor.nextEquation().variable, .a)
        XCTAssertEqual(executor.nextEquation().variable, .b)
        XCTAssertEqual(executor.nextEquation().variable, .c)
        XCTAssertEqual(executor.nextEquation().variable, .d)
    }
}
