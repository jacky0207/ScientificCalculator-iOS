//
//  ScientificCalculator.swift
//  ScientificCalculator
//
//  Created by Jacky Lam on 2023-11-19.
//

class ScientificCalculator: Calculator {
    private(set) var text: String = ""
    private(set) var answer: Double = 0.0
    private let keys = CalculatorKeyList()
    private(set) var controlPanel: CalculatorControlPanel = ScientificCalculatorControlPanel()

    func appendKey(_ key: CalculatorKey) {
        controlPanel.appendKey(key, to: keys)
        text = keys.text
    }

    func delete() {
        controlPanel.delete(for: keys)
        text = keys.text
    }

    func clearAll() {
        controlPanel.clearAll(for: keys)
        text = keys.text
        answer = 0
    }

    func calculate() throws {
        let answer = try controlPanel.calculate(for: keys)
        self.answer = answer
    }
}
