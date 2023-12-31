//
//  CalculatorControlPanel.swift
//  ScientificCalculator
//
//  Created by Jacky Lam on 2023-11-19.
//

public protocol CalculatorControlPanel {
    func appendKey(_ key: CalculatorKey, to keys: CalculatorKeyList)
    func delete(for keys: CalculatorKeyList)
    func clearAll(for keys: CalculatorKeyList)
    func calculate(for keys: CalculatorKeyList, with values: [CalculatorVariable: Double], params: [CalculatorParam: Any]) throws -> Double
}
