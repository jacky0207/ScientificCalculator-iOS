//
//  CalculatorKey.swift
//  ScientificCalculator
//
//  Created by Jacky Lam on 2023-11-17.
//

enum CalculatorKey: Equatable, Hashable {
    case number(_ number: CalculatorNumber)
    case `operator`(_ operator: CalculatorOperator)
    case function(_ function: CalculatorFunction)
    case variable(_ variable: CalculatorVariable)
}

extension CalculatorKey {
    var text: String {
        switch self {
        case .number(let number):
            return number.rawValue
        case .operator(let `operator`):
            return `operator`.rawValue
        case .function(let function):
            return function.rawValue
        case .variable(let variable):
            return variable.rawValue
        }
    }

    var buttonText: String {
        switch self {
        case .number(let number):
            return number.rawValue
        case .operator(let `operator`):
            return `operator`.rawValue
        case .function(let function):
            return function.buttonText
        case .variable(let variable):
            return variable.rawValue
        }
    }
}

enum CalculatorNumber: String, CaseIterable {
    case zero = "0"
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case dot = "."
}

enum CalculatorOperator: String, CaseIterable {
    case plus = "+"
    case minus = "-"
    case multiply = "x"
    case divide = "÷"
}

enum CalculatorFunction: String, CaseIterable {
    case factorial = "!"
    case power = "^"
    case inverseFraction = "\u{207B}\u{00B9}"
    case square = "\u{00B2}"
    case cube = "\u{00B3}"
    case root = "\u{02E3}\u{221A}"
    case squareRoot = "\u{221A}"
    case cubeRoot = "\u{221B}"
    case log = "log"
    case naturalLog = "ln"
    case powerOfTen = "\u{2081}\u{2080}"
    case exponential = "e"
    case sin = "sin"
    case cos = "cos"
    case tan = "tan"
    case openBracket = "("
    case closeBracket = ")"
}

extension CalculatorFunction {
    var buttonText: String {
        switch self {
        case .factorial:
            return "x\(rawValue)"
        case .inverseFraction, .square, .cube:
            return "x\(rawValue)"
        case .powerOfTen, .exponential:
            return "\(rawValue)x"
        default:
            return rawValue
        }
    }
}

enum CalculatorVariable: String, CaseIterable {
    case a = "a"
    case b = "b"
    case c = "c"
    case d = "d"
    case x = "x"
    case y = "y"
}

// MARK: - CalculatorKeyPair
struct CalculatorKeyPair {
    var open: CalculatorFunction
    var close: CalculatorFunction
}
