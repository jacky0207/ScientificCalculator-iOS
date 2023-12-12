//
//  ScientificCalculatorControlPanel.swift
//  ScientificCalculator
//
//  Created by Jacky Lam on 2023-11-19.
//

class ScientificCalculatorControlPanel: CalculatorControlPanel {
    func appendKey(_ key: CalculatorKey, to keys: CalculatorKeyList) {
        keys.append(key)
    }

    func delete(for keys: CalculatorKeyList) {
        _ = keys.popLast()
    }

    func clearAll(for keys: CalculatorKeyList) {
        keys.removeAll()
    }

    func calculate(for keys: CalculatorKeyList, with values: [CalculatorVariable: Double], params: [CalculatorParam: Any]) throws -> Double {
        return try ScientificCalculatorCalculation().calculate(for: keys, with: values, params: params)
    }
}
