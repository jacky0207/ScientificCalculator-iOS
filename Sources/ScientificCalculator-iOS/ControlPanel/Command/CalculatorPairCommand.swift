//
//  CalculatorPairCommand.swift
//  ScientificCalculator
//
//  Created by Jacky Lam on 2023-11-21.
//

import Foundation

enum CalculatorPairCommandError: Error {
    case invalidOpen
    case invalidMiddle
    case invalidClose
}

extension CalculatorPairCommandError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidOpen:
            return "Open bracket should be closed"
        case .invalidMiddle:
            return "Node should be exist in bracket"
        case .invalidClose:
            return "Bracket should be closed with open bracket"
        }
    }
}

protocol CalculatorPairCommand {
    func execute(from open: CalculatorKeyNode, to close: CalculatorKeyNode, convert: (CalculatorKeyList) throws -> CalculatorKeyList) throws -> CalculatorCommandResult
}

// MARK: - CalculatorKeyPair
extension CalculatorKeyPair {
    static var bracketCommandKeyPair: CalculatorKeyPair {
        return CalculatorKeyPair(open: .openBracket, close: .closeBracket)
    }
}
