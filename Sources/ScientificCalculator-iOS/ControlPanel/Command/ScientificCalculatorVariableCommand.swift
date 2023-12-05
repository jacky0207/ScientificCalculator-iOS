//
//  ScientificCalculatorVariableCommand.swift
//  
//
//  Created by Jacky Lam on 2023-11-25.
//

import Foundation

class ScientificCalculatorVariableCommand: ScientificCalculatorCommand, CalculatorVariableCommand {
    override func previousNumberType() -> CalculatorCommandType {
        return .optional
    }

    override func execute(node: CalculatorKeyNode) throws -> CalculatorCommandResult {
        fatalError("Please use execute(node:value:)")
    }

    func execute(node: CalculatorKeyNode, value: Double) throws -> CalculatorCommandResult {
        if let next = node.next, case .number = next.key {
            throw CalculatorCommandError.invalidTail
        }
        if let prev = node.prev, case .number = prev.key {  // hidden multiply has higher priority than function
            let head = try previousNumberHead(of: node)
            let left = try previousNumber(from: head, before: node)
            let answer = left * value
            let newKeys = try CalculatorKeyConverter().convertKeys(from: answer)
            return CalculatorCommandResult(
                head: head,
                tail: node,
                newKeys: newKeys
            )
        } else {
            let newKeys = try CalculatorKeyConverter().convertKeys(from: value)
            return CalculatorCommandResult(
                head: node,
                tail: node,
                newKeys: newKeys
            )
        }
    }
}
