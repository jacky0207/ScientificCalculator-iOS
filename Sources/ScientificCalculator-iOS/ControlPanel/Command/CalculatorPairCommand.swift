//
//  CalculatorPairCommand.swift
//  ScientificCalculator
//
//  Created by Jacky Lam on 2023-11-21.
//

import Foundation

protocol CalculatorPairCommand {
    func execute(from open: CalculatorKeyNode, to close: CalculatorKeyNode, convert: (CalculatorKeyList) throws -> CalculatorKeyList) throws -> CalculatorCommandResult
}

// MARK: - CalculatorKeyPair
extension CalculatorKeyPair {
    static var bracketCommandKeyPair: CalculatorKeyPair {
        return CalculatorKeyPair(open: .openBracket, close: .closeBracket)
    }
}
