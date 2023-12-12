//
//  ScientificCalculatorOperatorCommand.swift
//  ScientificCalculator
//
//  Created by Jacky Lam on 2023-11-22.
//

class ScientificCalculatorPlusCommand: ScientificCalculatorCommand {
    override func execute(node: CalculatorKeyNode, params: [CalculatorParam: Any]) throws -> CalculatorCommandResult {
        if node.prev == nil && node.next != nil {  // no calculation for +ve sign, i.e. +1, -sqrt(4)
            return CalculatorCommandResult(head: node, tail: node, newKeys: CalculatorKeyList(CalculatorKeyNode(key: node.key)))  // new key should be no prev and next
        }
        return try super.execute(node: node, params: params)
    }

    override func answer(left: Double, right: Double, params: [CalculatorParam: Any]) throws -> Double {
        return left + right
    }
}

class ScientificCalculatorMinusCommand: ScientificCalculatorCommand {
    override func execute(node: CalculatorKeyNode, params: [CalculatorParam: Any]) throws -> CalculatorCommandResult {
        if node.prev == nil && node.next != nil {
            return CalculatorCommandResult(head: node, tail: node, newKeys: CalculatorKeyList(CalculatorKeyNode(key: node.key)))  // new key should be no prev and next
        }
        return try super.execute(node: node, params: params)
    }

    override func answer(left: Double, right: Double, params: [CalculatorParam: Any]) throws -> Double {
        return left - right
    }
}

class ScientificCalculatorMultiplyCommand: ScientificCalculatorCommand {
    override func answer(left: Double, right: Double, params: [CalculatorParam: Any]) throws -> Double {
        return left * right
    }
}

class ScientificCalculatorDivideCommand: ScientificCalculatorCommand {
    override func answer(left: Double, right: Double, params: [CalculatorParam: Any]) throws -> Double {
        return left / right
    }
}
