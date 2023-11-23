//
//  ScientificCalculatorKeyEditorTests.swift
//  ScientificCalculatorTests
//
//  Created by Jacky Lam on 2023-11-20.
//

import XCTest
@testable import ScientificCalculator_iOS

final class ScientificCalculatorKeyEditorTests: XCTestCase {
    let editor = CalculatorKeyEditor()

    override func setUpWithError() throws {

    }

    override func tearDownWithError() throws {

    }

    func testScientificCalculatorKeyEditor_ReplaceHead() {
        let keys = CalculatorKeyList()
        let head = CalculatorKeyNode(key: .number(.one))
        let tail = CalculatorKeyNode(key: .number(.two))
        keys.append(from: head)
        keys.append(.operator(.plus))
        keys.append(from: tail)
        keys.append(.operator(.plus))
        keys.append(.number(.four))
        let newKeys = CalculatorKeyList()
        let newNode = CalculatorKeyNode(key: .number(.three))
        newKeys.append(from: newNode)
        editor.replace(keys, from: head, to: tail, with: newKeys)
        XCTAssertEqual(keys.text, "3+4")
        XCTAssertTrue(keys.head === newNode)
    }

    func testScientificCalculatorKeyEditor_ReplaceMiddle() {
        let keys = CalculatorKeyList()
        let head = CalculatorKeyNode(key: .number(.one))
        let tail = CalculatorKeyNode(key: .number(.two))
        keys.append(.number(.four))
        keys.append(.operator(.plus))
        keys.append(from: head)
        keys.append(.operator(.plus))
        keys.append(from: tail)
        keys.append(.operator(.plus))
        keys.append(.number(.three))
        let newKeys = CalculatorKeyList()
        let newNode = CalculatorKeyNode(key: .number(.three))
        newKeys.append(from: newNode)
        editor.replace(keys, from: head, to: tail, with: newKeys)
        XCTAssertEqual(keys.text, "4+3+3")
    }

    func testScientificCalculatorKeyEditor_ReplaceTail() {
        let keys = CalculatorKeyList()
        let head = CalculatorKeyNode(key: .number(.two))
        let tail = CalculatorKeyNode(key: .number(.three))
        keys.append(.number(.one))
        keys.append(.operator(.plus))
        keys.append(from: head)
        keys.append(.operator(.plus))
        keys.append(from: tail)
        let newKeys = CalculatorKeyList()
        let newNode = CalculatorKeyNode(key: .number(.five))
        newKeys.append(from: newNode)
        editor.replace(keys, from: head, to: tail, with: newKeys)
        XCTAssertEqual(keys.text, "1+5")
        XCTAssertTrue(keys.tail === newNode)
    }

    func testScientificCalculatorKeyEditor_ReplaceAll() {
        let keys = CalculatorKeyList()
        let head = CalculatorKeyNode(key: .number(.one))
        let tail = CalculatorKeyNode(key: .number(.two))
        keys.append(from: head)
        keys.append(.operator(.plus))
        keys.append(from: tail)
        let newKeys = CalculatorKeyList()
        let newNode = CalculatorKeyNode(key: .number(.three))
        newKeys.append(from: newNode)
        editor.replace(keys, from: head, to: tail, with: newKeys)
        XCTAssertEqual(keys.text, "3")
        XCTAssertTrue(keys.head === newNode)
        XCTAssertTrue(keys.tail === newNode)
    }
}
