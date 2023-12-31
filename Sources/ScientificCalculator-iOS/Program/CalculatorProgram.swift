//
//  CalculatorProgram.swift
//  
//
//  Created by Jacky Lam on 2023-11-25.
//

public protocol CalculatorProgram {
    var name: String { get set }
    var equations: [CalculatorProgramEquation] { get set }
    var subEquations: [CalculatorProgramSubEquation] { get set }
}

public protocol CalculatorProgramEquation {
    var variable: CalculatorVariable { get set }
    var keys: CalculatorKeyList { get set }
}

public enum CalculatorProgramEquationType {
    case input
    case fixed(_ equation: CalculatorKeyList)

    var keys: CalculatorKeyList? {
        switch self {
        case .input:
            return nil
        case .fixed(let calculatorKeyList):
            return calculatorKeyList
        }
    }
}

public protocol CalculatorProgramSubEquation {
    var variable: CalculatorVariable { get set }
    var type: CalculatorProgramEquationType { get set }
}
