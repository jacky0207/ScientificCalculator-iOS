//
//  ScientificCalculatorControlPanelTests.swift
//  ScientificCalculatorTests
//
//  Created by Jacky Lam on 2023-11-19.
//

import XCTest
@testable import ScientificCalculator_iOS

final class ScientificCalculatorControlPanelTests: XCTestCase {
    let controlPanel: CalculatorControlPanel = ScientificCalculatorControlPanel()
    var keys = CalculatorKeyList()

    override func setUpWithError() throws {
        controlPanel.clearAll(for: keys)
    }

    override func tearDownWithError() throws {

    }

    func testScientificCalculatorControlPanel_InsertKey() throws {
        controlPanel.appendKey(.number(.one), to: keys)
        XCTAssertEqual(keys.head?.key, .number(.one))
    }

    func testScientificCalculatorControlPanel_Delete() throws {
        controlPanel.appendKey(.number(.one), to: keys)
        controlPanel.appendKey(.number(.two), to: keys)
        controlPanel.appendKey(.number(.three), to: keys)
        controlPanel.delete(for: keys)
        XCTAssertEqual(keys.text, "12")
    }

    func testScientificCalculatorControlPanel_ClearAll() throws {
        controlPanel.appendKey(.number(.one), to: keys)
        controlPanel.appendKey(.number(.two), to: keys)
        controlPanel.appendKey(.number(.three), to: keys)
        controlPanel.clearAll(for: keys)
        XCTAssertEqual(keys.head?.key, nil)
    }

    func testScientificCalculatorControlPanel_calculate() throws {
        controlPanel.appendKey(.number(.two), to: keys)
        controlPanel.appendKey(.function(.openBracket), to: keys)
        controlPanel.appendKey(.function(.openBracket), to: keys)
        controlPanel.appendKey(.number(.one), to: keys)
        controlPanel.appendKey(.operator(.plus), to: keys)
        controlPanel.appendKey(.number(.two), to: keys)
        controlPanel.appendKey(.function(.closeBracket), to: keys)
        controlPanel.appendKey(.operator(.multiply), to: keys)
        controlPanel.appendKey(.number(.three), to: keys)
        controlPanel.appendKey(.function(.closeBracket), to: keys)
        controlPanel.appendKey(.function(.sin), to: keys)
        controlPanel.appendKey(.number(.three), to: keys)
        controlPanel.appendKey(.number(.zero), to: keys)
        XCTAssertEqual(try controlPanel.calculate(for: keys), 9)
    }
}
