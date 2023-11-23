//
//  ScientificCalculatorOperatorCommand.swift
//  ScientificCalculator
//
//  Created by Jacky Lam on 2023-11-22.
//

class ScientificCalculatorPlusCommand: ScientificCalculatorCommand {
    override func execute(node: CalculatorKeyNode) throws -> CalculatorCommandResult {
        if node.prev == nil && node.next != nil {  // no calculation for +ve sign, i.e. +1, -sqrt(4)
            return CalculatorCommandResult(head: node, tail: node, newKeys: CalculatorKeyList(node))
        }
        return try super.execute(node: node)
    }

    override func answer(left: Double, right: Double) throws -> Double {
        return left + right
    }
}

class ScientificCalculatorMinusCommand: ScientificCalculatorCommand {
    override func execute(node: CalculatorKeyNode) throws -> CalculatorCommandResult {
        if node.prev == nil && node.next != nil {
            return CalculatorCommandResult(head: node, tail: node, newKeys: CalculatorKeyList(node))  // no calculation for +ve sign, i.e. +1
        }
        return try super.execute(node: node)
    }

    override func answer(left: Double, right: Double) throws -> Double {
        return left - right
    }
}

class ScientificCalculatorMultiplyCommand: ScientificCalculatorCommand {
    override func answer(left: Double, right: Double) throws -> Double {
        return left * right
    }
}

class ScientificCalculatorDivideCommand: ScientificCalculatorCommand {
    override func answer(left: Double, right: Double) throws -> Double {
        return left / right
    }
}
