//
//  CalculatorCalculation.swift
//  ScientificCalculator
//
//  Created by Jacky Lam on 2023-11-18.
//

protocol CalculatorCalculation {
    func executeCalculateKeys(_ keys: [CalculatorKey], params: [CalculatorParam: Any], for pressedKeys: CalculatorKeyList) throws -> CalculatorKeyList
    func simplifyPlusMinus(for keys: CalculatorKeyList, params: [CalculatorParam: Any]) throws -> CalculatorKeyList
    func simplifyMultiplyDivide(for keys: CalculatorKeyList, params: [CalculatorParam: Any]) throws -> CalculatorKeyList
    func simplifyFunction(for keys: CalculatorKeyList, params: [CalculatorParam: Any]) throws -> CalculatorKeyList
    func executeCalculateVariable(_ variables: [CalculatorVariable], with values: [CalculatorVariable: Double], for pressedKeys: CalculatorKeyList) throws -> CalculatorKeyList
    func simplifyVariable(for keys: CalculatorKeyList, with values: [CalculatorVariable: Double]) throws -> CalculatorKeyList
    func executeCalculateKeyPair(_ keyPair: CalculatorKeyPair, with values: [CalculatorVariable: Double], params: [CalculatorParam: Any], for pressedKeys: CalculatorKeyList) throws -> CalculatorKeyList
    func simplifyBracket(for keys: CalculatorKeyList, with values: [CalculatorVariable: Double], params: [CalculatorParam: Any]) throws -> CalculatorKeyList
    func calculate(for keys: CalculatorKeyList, with values: [CalculatorVariable: Double], params: [CalculatorParam: Any]) throws -> Double
}

extension CalculatorCalculation {
    func executeCalculateKeys(_ keys: [CalculatorKey], params: [CalculatorParam: Any], for pressedKeys: CalculatorKeyList) throws -> CalculatorKeyList {
        var node = pressedKeys.head
        while true {
            guard let curr = node else {
                break
            }
            if keys.contains(curr.key) {
                let command = ScientificCalculatorCommandFactory.shared.commandInstance(of: curr.key)
                let result = try command.execute(node: curr, params: params)
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

    func executeCalculateKeyPair(_ keyPair: CalculatorKeyPair, with values: [CalculatorVariable: Double], params: [CalculatorParam: Any], for pressedKeys: CalculatorKeyList) throws -> CalculatorKeyList {
        var node = pressedKeys.head
        var openBracketStack = [CalculatorKeyNode]()
        while true {
            guard let curr = node else {
                break
            }
            if case .bracket(let bracket) = curr.key, keyPair.open == bracket {
                openBracketStack.append(curr)
                node = curr.next
            } else if case .bracket(let bracket) = curr.key, keyPair.close == bracket {
                guard let openBracket = openBracketStack.popLast() else {
                    throw CalculatorError.syntax
                }
                let command = ScientificCalculatorCommandFactory.shared.bracketPairCommandInstance(of: bracket)
                let result = try command.execute(from: openBracket, to: curr) { keys in
                    try CalculatorKeyConverter().convertKeys(from: calculate(for: keys, with: values, params: params))
                }
                CalculatorKeyEditor().replace(pressedKeys, withResult: result)
                node = result.newKeys.tail?.next
            } else {
                node = curr.next
            }
        }
        if !openBracketStack.isEmpty {
            throw CalculatorError.syntax
        }
        return pressedKeys
    }
}
