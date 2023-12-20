//
//  CalculatorLogHistory.swift
//  
//
//  Created by Jacky Lam on 2023-11-27.
//

public protocol CalculatorLog {
    var id: String { get set }
    var keys: CalculatorKeyList { get set }
    var answer: Double { get set }
    var variable: CalculatorVariable { get set }
}

public protocol CalculatorLogHistory {
    var logs: [CalculatorLog] { get }
    func append(_ log: CalculatorLog)
    func removeAll()
}
