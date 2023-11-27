//
//  Calculator.swift
//  ScientificCalculator
//
//  Created by Jacky Lam on 2023-11-17.
//

protocol Calculator {
    // mode
    var mode: CalculatorMode { get }
    // components
    var storage: CalculatorStorage { get }
    var displayScreen: CalculatorDisplayScreen { get }
    var controlPanel: CalculatorControlPanel { get }
    var programExecutor: CalculatorProgramExecutor { get }
    // additional components
    var logHistory: CalculatorLogHistory { get }
    // accessible property
    var text: String { get }
    var answer: Double { get }
    // functions
    func appendKey(_ key: CalculatorKey)
    func setKeys(_ keys: CalculatorKeyList)
    func delete()
    func clearAll()
    func calculate() throws
    func calculate(to variable: CalculatorVariable) throws
    // program
    func execute(for program: CalculatorProgram)
}
