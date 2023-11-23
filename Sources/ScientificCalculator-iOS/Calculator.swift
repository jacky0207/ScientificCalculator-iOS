//
//  Calculator.swift
//  ScientificCalculator
//
//  Created by Jacky Lam on 2023-11-17.
//

protocol Calculator {
    var text: String { get }
    var answer: Double { get }
    var controlPanel: CalculatorControlPanel { get }
    func appendKey(_ key: CalculatorKey)
    func delete()
    func clearAll()
    func calculate() throws
}
