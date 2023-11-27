//
//  ScientificCalculatorLogHistoryTests.swift
//  
//
//  Created by Jacky Lam on 2023-11-27.
//

import XCTest
@testable import ScientificCalculator_iOS

final class ScientificCalculatorLogHistoryTests: XCTestCase {
    let logHistory: CalculatorLogHistory = ScientificCalculatorLogHistory()
    
    override func setUpWithError() throws {
        logHistory.removeAll()
    }
    
    override func tearDownWithError() throws {
        
    }
    
    func testScientificCalculatorLogHistory_Append() {
        logHistory.append(ScientificCalculatorLog(
            keys: CalculatorKeyList(.number(.one), .operator(.plus), .number(.two)),
            answer: 3
        ))
        XCTAssertTrue(!logHistory.logs.isEmpty)
    }
    
    func testScientificCalculatorLogHistory_RemoveAll() {
        logHistory.append(ScientificCalculatorLog(
            keys: CalculatorKeyList(.number(.one), .operator(.plus), .number(.two)),
            answer: 3
        ))
        logHistory.removeAll()
        XCTAssertTrue(logHistory.logs.isEmpty)
    }
}
