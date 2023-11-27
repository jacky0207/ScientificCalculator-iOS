//
//  CalculatorLogHistory.swift
//  
//
//  Created by Jacky Lam on 2023-11-27.
//

protocol CalculatorLog {
    var keys: CalculatorKeyList { get set }
    var answer: Double { get set }
    init(keys: CalculatorKeyList, answer: Double)
}

protocol CalculatorLogHistory {
    var logs: [CalculatorLog] { get }
    func append(_ log: CalculatorLog)
    func removeAll()
}
