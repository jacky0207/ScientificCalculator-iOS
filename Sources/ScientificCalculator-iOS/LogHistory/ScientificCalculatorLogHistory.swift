//
//  ScientificCalculatorLogHistory.swift
//  
//
//  Created by Jacky Lam on 2023-11-27.
//

import Foundation

public class ScientificCalculatorLog: CalculatorLog {
    public var id: String = UUID().uuidString
    public var keys: CalculatorKeyList
    public var answer: Double
    public var variable: CalculatorVariable

    public init(
        keys: CalculatorKeyList,
        answer: Double,
        variable: CalculatorVariable
    ) {
        self.keys = keys
        self.answer = answer
        self.variable = variable
    }
}

class ScientificCalculatorLogHistory: CalculatorLogHistory {
    private(set) var logs: [CalculatorLog] = []

    func append(_ log: CalculatorLog) {
        logs.append(log)
    }

    func removeAll() {
        logs.removeAll()
    }
}
