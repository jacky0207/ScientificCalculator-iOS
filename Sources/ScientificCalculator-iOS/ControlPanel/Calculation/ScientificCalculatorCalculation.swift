//
//  ScientificCalculatorCalculation.swift
//  ScientificCalculator
//
//  Created by Jacky Lam on 2023-11-19.
//

class ScientificCalculatorCalculation: CalculatorCalculation {
    func simplifyPlusMinus(for keys: CalculatorKeyList, params: [CalculatorParam: Any]) throws -> CalculatorKeyList {
        return try executeCalculateKeys(
            CalculatorKey.plusMinusCommandKeys,
            params: params,
            for: keys
        )
    }

    func simplifyMultiplyDivide(for keys: CalculatorKeyList, params: [CalculatorParam: Any]) throws -> CalculatorKeyList {
        return try executeCalculateKeys(
            CalculatorKey.multiplyDivideCommandKeys,
            params: params,
            for: keys
        )
    }

    func simplifyFunction(for keys: CalculatorKeyList, params: [CalculatorParam: Any]) throws -> CalculatorKeyList {
        return try executeCalculateKeys(
            CalculatorKey.functionCommandKeys,
            params: params,
            for: keys
        )
    }

    func simplifyVariable(for keys: CalculatorKeyList, with values: [CalculatorVariable: Double]) throws -> CalculatorKeyList {
        return try executeCalculateVariable(
            CalculatorVariable.variableCommandKeys,
            with: values,
            for: keys
        )
    }

    func simplifyBracket(for keys: CalculatorKeyList, with values: [CalculatorVariable: Double], params: [CalculatorParam: Any]) throws -> CalculatorKeyList {
        return try executeCalculateKeyPair(
            CalculatorKeyPair.bracketCommandKeyPair,
            with: values,
            params: params,
            for: keys
        )
    }

    func calculate(for keys: CalculatorKeyList, with values: [CalculatorVariable: Double], params: [CalculatorParam: Any]) throws -> Double {
        var newKeys = keys.copy() as! CalculatorKeyList
        newKeys = try simplifyBracket(for: newKeys, with: values, params: params)
        newKeys = try simplifyVariable(for: newKeys, with: values)
        newKeys = try simplifyFunction(for: newKeys, params: params)
        newKeys = try simplifyMultiplyDivide(for: newKeys, params: params)
        newKeys = try simplifyPlusMinus(for: newKeys, params: params)
        return try CalculatorKeyConverter().convertNumber(for: newKeys)
    }
}
