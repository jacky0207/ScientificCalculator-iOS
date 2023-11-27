//
//  ScientificCalculatorCalculation.swift
//  ScientificCalculator
//
//  Created by Jacky Lam on 2023-11-19.
//

class ScientificCalculatorCalculation: CalculatorCalculation {
    func simplifyPlusMinus(for keys: CalculatorKeyList) throws -> CalculatorKeyList {
        return try executeCalculateKeys(
            CalculatorKey.plusMinusCommandKeys,
            for: keys
        )
    }

    func simplifyMultiplyDivide(for keys: CalculatorKeyList) throws -> CalculatorKeyList {
        return try executeCalculateKeys(
            CalculatorKey.multiplyDivideCommandKeys,
            for: keys
        )
    }

    func simplifyFunction(for keys: CalculatorKeyList) throws -> CalculatorKeyList {
        return try executeCalculateKeys(
            CalculatorKey.functionCommandKeys,
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

    func simplifyBracket(for keys: CalculatorKeyList, with values: [CalculatorVariable: Double]) throws -> CalculatorKeyList {
        return try executeCalculateKeyPair(
            CalculatorKeyPair.bracketCommandKeyPair,
            with: values,
            for: keys
        )
    }

    func calculate(for keys: CalculatorKeyList, with values: [CalculatorVariable: Double]) throws -> Double {
        var newKeys = keys.copy() as! CalculatorKeyList
        newKeys = try simplifyBracket(for: newKeys, with: values)
        newKeys = try simplifyVariable(for: newKeys, with: values)
        newKeys = try simplifyFunction(for: newKeys)
        newKeys = try simplifyMultiplyDivide(for: newKeys)
        newKeys = try simplifyPlusMinus(for: newKeys)
        return try CalculatorKeyConverter().convertNumber(for: newKeys)
    }
}
