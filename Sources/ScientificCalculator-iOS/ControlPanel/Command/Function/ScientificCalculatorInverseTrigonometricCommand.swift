//
//  ScientificCalculatorInverseTrigonometricCommand.swift
//
//
//  Created by Jacky Lam on 2023-11-27.
//

import Foundation

class ScientificCalculatorInverseSinCommand: ScientificCalculatorCommand {
    override func previousNumberType() -> CalculatorCommandType {
        return .optional
    }

    override func answer(left: Double, right: Double) throws -> Double {
        return left * asin(right) / .pi * 180
    }
}

class ScientificCalculatorInverseCosCommand: ScientificCalculatorCommand {
    override func previousNumberType() -> CalculatorCommandType {
        return .optional
    }

    override func answer(left: Double, right: Double) throws -> Double {
        return left * acos(right) / .pi * 180
    }
}

class ScientificCalculatorInverseTanCommand: ScientificCalculatorCommand {
    override func previousNumberType() -> CalculatorCommandType {
        return .optional
    }

    override func answer(left: Double, right: Double) throws -> Double {
        if right.truncatingRemainder(dividingBy: 180) == 90 {
            throw CalculatorError.math
        }
        return left * atan(right) / .pi * 180
    }
}
