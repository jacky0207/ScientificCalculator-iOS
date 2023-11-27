//
//  ScientificCalculatorKeyTravelerTests.swift
//  ScientificCalculatorTests
//
//  Created by Jacky Lam on 2023-11-19.
//

import XCTest
@testable import ScientificCalculator_iOS

final class ScientificCalculatorKeyTravelerTests: XCTestCase {
    let traveler = CalculatorKeyTraveler()

    override func setUpWithError() throws {

    }

    override func tearDownWithError() throws {

    }

    func testScientificCalculatorKeyTraveler_HasNext_Tail() throws {
        let keys = CalculatorKeyList()
        keys.append(.number(.one))
        keys.append(.number(.two))
        keys.append(.number(.three))
        XCTAssertEqual(traveler.tail(of: keys.head!).key.text, "3")
    }

    func testScientificCalculatorKeyTraveler_NoNext_Tail() throws {
        let keys = CalculatorKeyList()
        keys.append(.number(.one))
        XCTAssertEqual(traveler.tail(of: keys.head!).key.text, "1")
    }

    func testScientificCalculatorKeyTraveler_PrevNumber_NotExist() throws {
        let keys = CalculatorKeyList()
        let `operator` = CalculatorKeyNode(key: .operator(.plus))
        keys.append(from: `operator`)
        keys.append(.number(.one))
        XCTAssertEqual(traveler.prevNumberHead(of: `operator`)?.key.text, nil)
    }

    func testScientificCalculatorKeyTraveler_PrevNumber_NumberHead() throws {
        let keys = CalculatorKeyList()
        let `operator` = CalculatorKeyNode(key: .operator(.plus))
        keys.append(.number(.one))
        keys.append(.number(.two))
        keys.append(from: `operator`)
        XCTAssertEqual(traveler.prevNumberHead(of: `operator`)?.key.text, "1")
    }

    func testScientificCalculatorKeyTraveler_PrevNumber_PlusMinusHead() throws {
        let keys = CalculatorKeyList()
        let `operator` = CalculatorKeyNode(key: .operator(.plus))
        keys.append(.operator(.plus))
        keys.append(.operator(.minus))
        keys.append(.operator(.plus))
        keys.append(.operator(.minus))
        keys.append(.operator(.plus))
        keys.append(.number(.one))
        keys.append(.number(.two))
        keys.append(from: `operator`)
        XCTAssertEqual(traveler.prevNumberHead(of: `operator`)?.key.text, "+")
    }

    func testScientificCalculatorKeyTraveler_PrevNumberWithNumberHead_PlusMinusHead() throws {
        let keys = CalculatorKeyList()
        let `operator` = CalculatorKeyNode(key: .operator(.plus))
        keys.append(.number(.one))
        keys.append(.operator(.plus))
        keys.append(.number(.one))
        keys.append(.number(.two))
        keys.append(from: `operator`)
        XCTAssertEqual(traveler.prevNumberHead(of: `operator`)?.key.text, "1")
    }

    func testScientificCalculatorKeyTraveler_PrevNumberWithMultiplyDivideHead_PlusMinusHead() throws {
        let keys = CalculatorKeyList()
        let `operator` = CalculatorKeyNode(key: .operator(.plus))
        keys.append(.operator(.multiply))
        keys.append(.operator(.minus))
        keys.append(.operator(.plus))
        keys.append(.operator(.minus))
        keys.append(.operator(.plus))
        keys.append(.number(.one))
        keys.append(.number(.two))
        keys.append(from: `operator`)
        XCTAssertEqual(traveler.prevNumberHead(of: `operator`)?.key.text, "-")
    }

    func testScientificCalculatorKeyTraveler_PrevNumberWithVariableHead_PlusMinusHead() throws {
        let keys = CalculatorKeyList()
        let `operator` = CalculatorKeyNode(key: .operator(.plus))
        keys.append(.variable(.a))
        keys.append(.operator(.minus))
        keys.append(.operator(.plus))
        keys.append(.operator(.minus))
        keys.append(.operator(.plus))
        keys.append(.number(.one))
        keys.append(.number(.two))
        keys.append(from: `operator`)
        XCTAssertEqual(traveler.prevNumberHead(of: `operator`)?.key.text, "-")
    }

    func testScientificCalculatorKeyTraveler_PrevNumberWithBracketHead_PlusMinusHead() throws {
        let keys = CalculatorKeyList()
        let `operator` = CalculatorKeyNode(key: .operator(.plus))
        keys.append(.bracket(.closeBracket))
        keys.append(.operator(.minus))
        keys.append(.operator(.plus))
        keys.append(.operator(.minus))
        keys.append(.operator(.plus))
        keys.append(.number(.one))
        keys.append(.number(.two))
        keys.append(from: `operator`)
        XCTAssertEqual(traveler.prevNumberHead(of: `operator`)?.key.text, "+")
    }

    func testScientificCalculatorKeyTraveler_PrevNumberWithBracketTail_PlusMinusHead() throws {
        let keys = CalculatorKeyList()
        let `operator` = CalculatorKeyNode(key: .operator(.plus))
        keys.append(.operator(.minus))
        keys.append(.operator(.plus))
        keys.append(.operator(.minus))
        keys.append(.operator(.plus))
        keys.append(.number(.one))
        keys.append(.number(.two))
        keys.append(.bracket(.closeBracket))
        keys.append(from: `operator`)
        XCTAssertEqual(traveler.prevNumberHead(of: `operator`)?.key.text, nil)
    }

    func testScientificCalculatorKeyTraveler_NextNumber_NotExist() throws {
        let keys = CalculatorKeyList()
        let `operator` = CalculatorKeyNode(key: .operator(.plus))
        keys.append(.number(.one))
        keys.append(from: `operator`)
        XCTAssertEqual(traveler.nextNumberTail(of: `operator`)?.key.text, nil)
    }

    func testScientificCalculatorKeyTraveler_NextNumber_NumberTail() throws {
        let keys = CalculatorKeyList()
        let `operator` = CalculatorKeyNode(key: .operator(.plus))
        keys.append(from: `operator`)
        keys.append(.number(.two))
        keys.append(.number(.one))
        XCTAssertEqual(traveler.nextNumberTail(of: `operator`)?.key.text, "1")
    }

    func testScientificCalculatorKeyTraveler_NextNumber_PlusMinusTail() throws {
        let keys = CalculatorKeyList()
        let `operator` = CalculatorKeyNode(key: .operator(.plus))
        keys.append(from: `operator`)
        keys.append(.operator(.minus))
        keys.append(.operator(.plus))
        keys.append(.operator(.minus))
        keys.append(.operator(.plus))
        keys.append(.number(.one))
        keys.append(.number(.two))
        XCTAssertEqual(traveler.nextNumberTail(of: `operator`)?.key.text, "2")
    }

    func testScientificCalculatorKeyTraveler_NextNumberWithNumberTail_PlusMinusTail() throws {
        let keys = CalculatorKeyList()
        let `operator` = CalculatorKeyNode(key: .operator(.plus))
        keys.append(from: `operator`)
        keys.append(.number(.one))
        keys.append(.operator(.plus))
        keys.append(.number(.one))
        keys.append(.number(.two))
        XCTAssertEqual(traveler.nextNumberTail(of: `operator`)?.key.text, "1")
    }

    func testScientificCalculatorKeyTraveler_NextNumberWithMultiplyDivideTail_PlusMinusTail() throws {
        let keys = CalculatorKeyList()
        let `operator` = CalculatorKeyNode(key: .operator(.plus))
        keys.append(from: `operator`)
        keys.append(.operator(.multiply))
        keys.append(.operator(.minus))
        keys.append(.operator(.plus))
        keys.append(.operator(.minus))
        keys.append(.operator(.plus))
        keys.append(.number(.one))
        keys.append(.number(.two))
        XCTAssertEqual(traveler.nextNumberTail(of: `operator`)?.key.text, nil)
    }

    func testScientificCalculatorKeyTraveler_NextNumberWithFunctionHead_VariableTail() throws {
        let keys = CalculatorKeyList()
        let `operator` = CalculatorKeyNode(key: .operator(.plus))
        keys.append(from: `operator`)
        keys.append(.function(.cos))
        keys.append(.operator(.minus))
        keys.append(.operator(.plus))
        keys.append(.operator(.minus))
        keys.append(.operator(.plus))
        keys.append(.number(.one))
        keys.append(.number(.two))
        XCTAssertEqual(traveler.nextNumberTail(of: `operator`)?.key.text, nil)
    }

    func testScientificCalculatorKeyTraveler_NextNumberWithVariableHead_VariableTail() throws {
        let keys = CalculatorKeyList()
        let `operator` = CalculatorKeyNode(key: .operator(.plus))
        keys.append(from: `operator`)
        keys.append(.variable(.a))
        keys.append(.operator(.minus))
        keys.append(.operator(.plus))
        keys.append(.operator(.minus))
        keys.append(.operator(.plus))
        keys.append(.number(.one))
        keys.append(.number(.two))
        XCTAssertEqual(traveler.nextNumberTail(of: `operator`)?.key.text, nil)
    }

    func testScientificCalculatorKeyTraveler_NextNumberWithBracketHead_PlusMinusTail() throws {
        let keys = CalculatorKeyList()
        let `operator` = CalculatorKeyNode(key: .operator(.plus))
        keys.append(from: `operator`)
        keys.append(.bracket(.openBracket))
        keys.append(.operator(.minus))
        keys.append(.operator(.plus))
        keys.append(.operator(.minus))
        keys.append(.operator(.plus))
        keys.append(.number(.one))
        keys.append(.number(.two))
        XCTAssertEqual(traveler.nextNumberTail(of: `operator`)?.key.text, nil)
    }
}
