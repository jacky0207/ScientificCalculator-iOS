//
//  CalculatorCalculation.swift
//  ScientificCalculator
//
//  Created by Jacky Lam on 2023-11-18.
//

protocol CalculatorCalculation {
    func executeCalculateKeys(_ keys: [CalculatorKey], for pressedKeys: CalculatorKeyList) throws -> CalculatorKeyList
    func simplifyPlusMinus(for keys: CalculatorKeyList) throws -> CalculatorKeyList
    func simplifyMultiplyDivide(for keys: CalculatorKeyList) throws -> CalculatorKeyList
    func simplifyFunction(for keys: CalculatorKeyList) throws -> CalculatorKeyList
    func executeCalculateVariable(_ variables: [CalculatorVariable], with values: [CalculatorVariable: Double], for pressedKeys: CalculatorKeyList) throws -> CalculatorKeyList
    func simplifyVariable(for keys: CalculatorKeyList, with values: [CalculatorVariable: Double]) throws -> CalculatorKeyList
    func executeCalculateKeyPair(_ keyPair: CalculatorKeyPair, with values: [CalculatorVariable: Double], for pressedKeys: CalculatorKeyList) throws -> CalculatorKeyList
    func simplifyBracket(for keys: CalculatorKeyList, with values: [CalculatorVariable: Double]) throws -> CalculatorKeyList
    func calculate(for keys: CalculatorKeyList, with values: [CalculatorVariable: Double]) throws -> Double
}

extension CalculatorCalculation {
    func executeCalculateKeys(_ keys: [CalculatorKey], for pressedKeys: CalculatorKeyList) throws -> CalculatorKeyList {
        var node = pressedKeys.head
        while true {
            guard let curr = node else {
                break
            }
            if keys.contains(curr.key) {
                let command = ScientificCalculatorCommandFactory.shared.commandInstance(of: curr.key)
                let result = try command.execute(node: curr)
                CalculatorKeyEditor().replace(pressedKeys, withResult: result)
                node = result.newKeys.tail?.next
            } else {
                node = curr.next
            }
        }
        return pressedKeys
    }

    func executeCalculateVariable(_ variables: [CalculatorVariable], with values: [CalculatorVariable: Double], for pressedKeys: CalculatorKeyList) throws -> CalculatorKeyList {
        var node = pressedKeys.head
        while true {
            guard let curr = node else {
                break
            }
            if case .variable(let variable) = curr.key, variables.contains(variable) {
                let command = ScientificCalculatorCommandFactory.shared.variableCommandInstance(of: variable)
                let result = try command.execute(node: curr, value: values[variable] ?? 0.0)
                CalculatorKeyEditor().replace(pressedKeys, withResult: result)
                node = result.newKeys.tail?.next
            } else {
                node = curr.next
            }
        }
        return pressedKeys
    }

    func executeCalculateKeyPair(_ keyPair: CalculatorKeyPair, with values: [CalculatorVariable: Double], for pressedKeys: CalculatorKeyList) throws -> CalculatorKeyList {
        var node = pressedKeys.head
        var openBracketStack = [CalculatorKeyNode]()
        while true {
            guard let curr = node else {
                break
            }
            if case .function(let function) = curr.key, keyPair.open == function {
                openBracketStack.append(curr)
                node = curr.next
            } else if case .function(let function) = curr.key, keyPair.close == function {
                guard let openBracket = openBracketStack.popLast() else {
                    throw CalculatorPairCommandError.invalidClose
                }
                let command = ScientificCalculatorCommandFactory.shared.functionPairCommandInstance(of: function)
                let result = try command.execute(from: openBracket, to: curr) { keys in
                    try CalculatorKeyConverter().convertKeys(from: calculate(for: keys, with: values))
                }
                CalculatorKeyEditor().replace(pressedKeys, withResult: result)
                node = result.newKeys.tail?.next
            } else {
                node = curr.next
            }
        }
        if !openBracketStack.isEmpty {
            throw CalculatorPairCommandError.invalidOpen
        }
        return pressedKeys
    }
}
