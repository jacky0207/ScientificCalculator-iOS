//
//  ScientificCalculatorList.swift
//  ScientificCalculatorTests
//
//  Created by Jacky Lam on 2023-11-19.
//

import XCTest
@testable import ScientificCalculator_iOS

final class ScientificCalculatorKeyListTests: XCTestCase {
    let keys = CalculatorKeyList()

    override func setUpWithError() throws {
        keys.removeAll()
    }

    override func tearDownWithError() throws {

    }

    func testScientificCalculatorKeyList_Decodable() {
        let url = Bundle.module.url(forResource: "CalculatorKeyList", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        let keys = try! JSONDecoder().decode(CalculatorKeyList.self, from: data)
        XCTAssertEqual(keys.text, "a+b")
    }

    func testScientificCalculatorKeyList_AppendKey() {
        keys.append(.number(.one))
        XCTAssertEqual(keys.head?.key, .number(.one))
        XCTAssertEqual(keys.head?.prev?.key, nil)  // entry should not be accessed from head
        keys.append(.number(.two))
        XCTAssertEqual(keys.head?.next?.key, .number(.two))
        XCTAssertEqual(keys.head?.next?.prev?.key, .number(.one))
    }

    func testScientificCalculatorKeyList_Text() {
        keys.append(.number(.one))
        keys.append(.number(.two))
        keys.append(.number(.three))
        XCTAssertEqual(keys.text, "123")
    }

    func testScientificCalculatorKeyList_Contain() {
        let node = CalculatorKeyNode(key: .number(.one))
        XCTAssertFalse(keys.contains(node))
        keys.append(from: node)
        XCTAssertTrue(keys.contains(node))
    }

    func testScientificCalculatorKeyList_RemoveAll() {
        keys.append(.number(.one))
        keys.append(.number(.two))
        keys.removeAll()
        XCTAssertEqual(keys.head?.key, nil)
    }

    func testScientificCalculatorKeyList_RemoveFrom() {
        let node = CalculatorKeyNode(key: .number(.two))
        keys.append(.number(.one))
        keys.append(from: node)
        keys.append(.number(.three))
        keys.remove(from: node)
        XCTAssertEqual(keys.text, "1")
    }

    func testScientificCalculatorKeyList_PopLast() {
        keys.append(.number(.one))
        keys.append(.number(.two))
        XCTAssertEqual(keys.popLast()?.key.text, "2")
        XCTAssertEqual(keys.text, "1")
        XCTAssertEqual(keys.popLast()?.key.text, "1")
        XCTAssertEqual(keys.text, "")
        XCTAssertEqual(keys.popLast()?.key.text, nil)
        XCTAssertEqual(keys.text, "")
    }
}
