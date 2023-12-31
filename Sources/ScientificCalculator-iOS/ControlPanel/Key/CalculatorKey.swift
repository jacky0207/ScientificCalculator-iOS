//
//  CalculatorKey.swift
//  ScientificCalculator
//
//  Created by Jacky Lam on 2023-11-17.
//

public enum CalculatorKey: Equatable, Hashable {
    case number(_ number: CalculatorNumber)
    case `operator`(_ operator: CalculatorOperator)
    case function(_ function: CalculatorFunction)
    case variable(_ variable: CalculatorVariable)
    case bracket(_ bracket: CalculatorBracket)
}

extension CalculatorKey {
    public var text: String {
        switch self {
        case .number(let number):
            return number.rawValue
        case .operator(let `operator`):
            return `operator`.rawValue
        case .function(let function):
            return function.rawValue
        case .variable(let variable):
            return variable.rawValue
        case .bracket(let bracket):
            return bracket.rawValue
        }
    }
}

public enum CalculatorNumber: String, CaseIterable {
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

public enum CalculatorOperator: String, CaseIterable {
    case plus = "+"
    case minus = "-"
    case multiply = "x"
    case divide = "÷"
}

public enum CalculatorFunction: String, CaseIterable {
    case exponent = "\u{1D07}"
    case pi = "\u{03C0}"
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
    case powerOfTen = "\u{0131}\u{006F}"
    case exponential = "e"
    case sin = "sin"
    case cos = "cos"
    case tan = "tan"
    case inverseSin = "sin\u{207B}\u{00B9}"
    case inverseCos = "cos\u{207B}\u{00B9}"
    case inverseTan = "tan\u{207B}\u{00B9}"
}

public enum CalculatorVariable: String, CaseIterable {
    case answer = "Ans"
    case a = "a"
    case b = "b"
    case c = "c"
    case d = "d"
    case x = "x"
    case y = "y"
}

public enum CalculatorBracket: String, CaseIterable {
    case openBracket = "("
    case closeBracket = ")"
}

// MARK: - CalculatorKeyPair
struct CalculatorKeyPair {
    var open: CalculatorBracket
    var close: CalculatorBracket
}
