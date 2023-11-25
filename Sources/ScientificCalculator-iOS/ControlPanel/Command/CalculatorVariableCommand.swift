//
//  CalculatorVariableCommand.swift
//  
//
//  Created by Jacky Lam on 2023-11-25.
//

protocol CalculatorVariableCommand {
    func execute(node: CalculatorKeyNode, value: Double) throws -> CalculatorCommandResult
}

// MARK: - CalculatorVariableCommand
extension CalculatorVariable {
    static var variableCommandKeys: [CalculatorVariable] {
        return [.a, .b, .c, .d]
    }
}

