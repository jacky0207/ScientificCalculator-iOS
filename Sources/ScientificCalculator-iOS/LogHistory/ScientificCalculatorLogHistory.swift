//
//  ScientificCalculatorLogHistory.swift
//  
//
//  Created by Jacky Lam on 2023-11-27.
//

public class ScientificCalculatorLog: CalculatorLog {
    public var keys: CalculatorKeyList
    public var answer: Double

    public init(keys: CalculatorKeyList, answer: Double) {
        self.keys = keys
        self.answer = answer
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
