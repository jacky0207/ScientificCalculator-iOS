//
//  CalculatorCommand.swift
//  ScientificCalculator
//
//  Created by Jacky Lam on 2023-11-19.
//

import Foundation

struct CalculatorCommandResult {
    var head: CalculatorKeyNode
    var tail: CalculatorKeyNode
    var newKeys: CalculatorKeyList
}

enum CalculatorCommandType {
    static let defaultNumber: Double = 1
    case exist
    case optional
    case notExist
}

protocol CalculatorCommand {
    func execute(node: CalculatorKeyNode, params: [CalculatorParam: Any]) throws -> CalculatorCommandResult
    func previousNumberType() -> CalculatorCommandType
    func previousNumberHead(of node: CalculatorKeyNode) throws -> CalculatorKeyNode
    func previousNumber(from head: CalculatorKeyNode, before node: CalculatorKeyNode) throws -> Double
    func nextNumberType() -> CalculatorCommandType
    func nextNumberTail(of node: CalculatorKeyNode) throws -> CalculatorKeyNode
    func nextNumber(after node: CalculatorKeyNode, to tail: CalculatorKeyNode) throws -> Double
    func answer(left: Double, right: Double, params: [CalculatorParam: Any]) throws -> Double
}

// MARK: - CalculatorKey
extension CalculatorKey {
    static var plusMinusCommandKeys: [CalculatorKey] {
        return CalculatorOperator.allCases
            .filter { type in
                switch type {
                case .plus, .minus:
                    return true
                case .multiply, .divide:
                    return false
                }
            }
            .map { .operator($0) }
    }

    static var multiplyDivideCommandKeys: [CalculatorKey] {
        return CalculatorOperator.allCases
            .filter { type in
                switch type {
                case .plus, .minus:
                    return false
                case .multiply, .divide:
                    return true
                }
            }
            .map { .operator($0) }
    }

    static var functionCommandKeys: [CalculatorKey] {
        return CalculatorFunction.allCases.map { .function($0) }
    }
}
