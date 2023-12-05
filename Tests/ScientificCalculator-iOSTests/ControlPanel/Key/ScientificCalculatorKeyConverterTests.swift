//
//  ScientificCalculatorConverterTests.swift
//  ScientificCalculatorTests
//
//  Created by Jacky Lam on 2023-11-19.
//

import XCTest
@testable import ScientificCalculator_iOS

final class ScientificCalculatorKeyConverterTests: XCTestCase {
    let converter = CalculatorKeyConverter()

    override func setUpWithError() throws {

    }

    override func tearDownWithError() throws {

    }

    func testScientificCalculatorKeyConverter_ConvertNumber() throws {
        let keys = CalculatorKeyList()
        keys.append(.number(.one))
        keys.append(.number(.two))
        keys.append(.number(.three))
        keys.append(.number(.dot))
        keys.append(.number(.four))
        XCTAssertEqual(try converter.convertNumber(from: keys.head!, to: keys.tail!), 123.4)
    }

    func testScientificCalculatorKeyConverter_WithList_ConvertNumber() throws {
        let keys = CalculatorKeyList()
        keys.append(.number(.one))
        keys.append(.number(.two))
        keys.append(.number(.three))
        keys.append(.number(.dot))
        keys.append(.number(.four))
        XCTAssertEqual(try converter.convertNumber(for: keys), 123.4)
    }

    func testScientificCalculatorKeyConverter_WithEmptyList_ConvertNumber_ReturnZero() throws {
        let keys = CalculatorKeyList()
        XCTAssertEqual(try converter.convertNumber(for: keys), 0)
    }

    func testScientificCalculatorKeyConverter_TailNotReach_throwException() throws {
        let keys = CalculatorKeyList()
        keys.append(.number(.one))
        keys.append(.number(.two))
        keys.append(.number(.three))
        XCTAssertThrowsError(try converter.convertNumber(from: keys.head!, to: CalculatorKeyNode(key: .number(.one)))) { error in
            XCTAssertEqual(error as? CalculatorKeyConverterError, CalculatorKeyConverterError.tailNotReach)
        }
    }

    func testScientificCalculatorKeyConverter_PlusMinusOnly_IncorrectKeyType() throws {
        let keys = CalculatorKeyList()
        keys.append(.operator(.plus))
        XCTAssertThrowsError(try converter.convertNumber(from: keys.head!, to: keys.tail!)) { error in
            XCTAssertEqual(error as? CalculatorKeyConverterError, CalculatorKeyConverterError.incorrectKeyType)
        }
    }

    func testScientificCalculatorKeyConverter_PlusMinusMiddle_IncorrectKeyType() throws {
        let keys = CalculatorKeyList()
        keys.append(.number(.one))
        keys.append(.number(.two))
        keys.append(.operator(.plus))
        keys.append(.number(.three))
        XCTAssertThrowsError(try converter.convertNumber(from: keys.head!, to: keys.tail!)) { error in
            XCTAssertEqual(error as? CalculatorKeyConverterError, CalculatorKeyConverterError.incorrectKeyType)
        }
    }

    func testScientificCalculatorKeyConverter_ContainsMultiplyDivide_IncorrectKeyType() throws {
        let keys = CalculatorKeyList()
        keys.append(.operator(.multiply))
        XCTAssertThrowsError(try converter.convertNumber(from: keys.head!, to: keys.tail!)) { error in
            XCTAssertEqual(error as? CalculatorKeyConverterError, CalculatorKeyConverterError.incorrectKeyType)
        }
    }

    func testScientificCalculatorKeyConverter_ContainsFunction_IncorrectKeyType() throws {
        let keys = CalculatorKeyList()
        keys.append(.bracket(.openBracket))
        XCTAssertThrowsError(try converter.convertNumber(from: keys.head!, to: keys.tail!)) { error in
            XCTAssertEqual(error as? CalculatorKeyConverterError, CalculatorKeyConverterError.incorrectKeyType)
        }
    }

    func testScientificCalculatorKeyConverter_ContainsVariable_IncorrectKeyType() throws {
        let keys = CalculatorKeyList()
        keys.append(.variable(.a))
        XCTAssertThrowsError(try converter.convertNumber(from: keys.head!, to: keys.tail!)) { error in
            XCTAssertEqual(error as? CalculatorKeyConverterError, CalculatorKeyConverterError.incorrectKeyType)
        }
    }

    func testScientificCalculatorKeyConverter_InvalidNumber_ThrowException() throws {
        let keys = CalculatorKeyList()
        keys.append(.number(.one))
        keys.append(.number(.two))
        keys.append(.number(.three))
        keys.append(.number(.dot))
        keys.append(.number(.dot))
        XCTAssertThrowsError(try converter.convertNumber(from: keys.head!, to: keys.tail!)) { error in
            XCTAssertEqual(error as? CalculatorKeyConverterError, CalculatorKeyConverterError.invalidNumber)
        }
    }

    func testScientificCalculatorKeyConverter_ConvertNumber_SignedNumber() throws {
        let keys = CalculatorKeyList()
        keys.append(.operator(.plus))
        keys.append(.operator(.minus))
        keys.append(.operator(.plus))
        keys.append(.operator(.minus))
        keys.append(.operator(.minus))
        keys.append(.number(.one))
        keys.append(.number(.two))
        keys.append(.number(.three))
        XCTAssertEqual(try converter.convertNumber(from: keys.head!, to: keys.tail!), -123)
    }

    func testScientificCalculatorKeyConverter_ConvertKeys() throws {
        XCTAssertEqual(try converter.convertKeys(from: 0).text, "0")
        XCTAssertEqual(try converter.convertKeys(from: 1.0).text, "1")
        XCTAssertEqual(try converter.convertKeys(from: 1.2).text, "1.2")
    }

    func testScientificCalculatorKeyConverter_ConvertKeys_NegativeNumber() throws {
        XCTAssertEqual(try converter.convertKeys(from: -1.0).text, "-1")
    }

    func testScientificCalculatorKeyConverter_OutOfRange_ThrowMathErrorException() throws {
        XCTAssertThrowsError(try converter.convertKeys(from: .nan).text, "-1") { error in
            XCTAssertEqual(error as? CalculatorKeyConverterError, .mathError)
        }
    }
}
