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

    func simplifyBracket(for keys: CalculatorKeyList) throws -> CalculatorKeyList {
        return try executeCalculateKeyPair(
            CalculatorKeyPair.bracketCommandKeyPair,
            for: keys
        )
    }

    func calculate(for keys: CalculatorKeyList) throws -> Double {
        var newKeys = keys.copy() as! CalculatorKeyList
        newKeys = try simplifyBracket(for: newKeys)
        newKeys = try simplifyFunction(for: newKeys)
        newKeys = try simplifyMultiplyDivide(for: newKeys)
        newKeys = try simplifyPlusMinus(for: newKeys)
        return try CalculatorKeyConverter().convertNumber(for: newKeys)
    }
}
