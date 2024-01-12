//
//  ScientificCalculatorProgramTests.swift
//
//
//  Created by Jacky Lam on 2024-01-08.
//

import XCTest
@testable import ScientificCalculator_iOS

final class ScientificCalculatorProgramTests: XCTestCase {
    override func setUpWithError() throws {

    }

    override func tearDownWithError() throws {

    }

    func testScientificCalculatorProgramExecutor_Decodable() {
        let url = Bundle.module.url(forResource: "CalculatorProgram", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        let program = try! JSONDecoder().decode(ScientificCalculatorProgram.self, from: data)
        XCTAssertEqual(program.id, 0)
        XCTAssertEqual(program.name, "Quadratic Equations")
        XCTAssertEqual(program.equations[0].id, 0)
        XCTAssertEqual(program.equations[0].programId, 0)
        XCTAssertEqual(program.equations[0].type, .main)
        XCTAssertEqual(program.equations[0].variable, .c)
        XCTAssertEqual(program.equations[0].keys.text, "a+b")
    }
}
