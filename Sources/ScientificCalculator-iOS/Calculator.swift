//
//  Calculator.swift
//  ScientificCalculator
//
//  Created by Jacky Lam on 2023-11-17.
//

protocol Calculator {
    var storage: CalculatorStorage { get }
    var displayScreen: CalculatorDisplayScreen { get }
    var controlPanel: CalculatorControlPanel { get }

    var text: String { get }
    var answer: Double { get }
    
    func appendKey(_ key: CalculatorKey)
    func delete()
    func clearAll()
    func calculate() throws
    func calculate(to variable: CalculatorVariable) throws
}
