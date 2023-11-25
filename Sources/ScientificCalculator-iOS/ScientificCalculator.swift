//
//  ScientificCalculator.swift
//  ScientificCalculator
//
//  Created by Jacky Lam on 2023-11-19.
//

class ScientificCalculator: Calculator {
    private(set) var storage: CalculatorStorage = ScientificCalculatorStorage()
    private(set) var displayScreen: CalculatorDisplayScreen = ScientificCalculatorDisplayScreen()
    private(set) var controlPanel: CalculatorControlPanel = ScientificCalculatorControlPanel()

    var text: String {
        return displayScreen.text
    }
    var answer: Double {
        return displayScreen.answer
    }

    func appendKey(_ key: CalculatorKey) {
        controlPanel.appendKey(key, to: storage.keys)
        displayScreen.text = storage.keys.text
    }

    func delete() {
        controlPanel.delete(for: storage.keys)
        displayScreen.text = storage.keys.text
    }

    func clearAll() {
        controlPanel.clearAll(for: storage.keys)
        displayScreen.text = storage.keys.text
        displayScreen.answer = 0
    }

    func calculate() throws {
        let answer = try controlPanel.calculate(for: storage.keys, with: storage.values)
        displayScreen.answer = answer
    }

    func calculate(to variable: CalculatorVariable) throws {
        let answer = try controlPanel.calculate(for: storage.keys, with: storage.values)
        displayScreen.answer = answer
    }
}
