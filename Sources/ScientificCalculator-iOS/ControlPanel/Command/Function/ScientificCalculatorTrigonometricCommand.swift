//
//  ScientificCalculatorTrigonometricCommand.swift
//  ScientificCalculator
//
//  Created by Jacky Lam on 2023-11-22.
//

import Foundation

class ScientificCalculatorSinCommand: ScientificCalculatorCommand {
    override func previousNumberType() -> CalculatorCommandType {
        return .optional
    }

    override func answer(left: Double, right: Double) throws -> Double {
        return left * __sinpi(right / 180)
    }
}

class ScientificCalculatorCosCommand: ScientificCalculatorCommand {
    override func previousNumberType() -> CalculatorCommandType {
        return .optional
    }

    override func answer(left: Double, right: Double) throws -> Double {
        return left * __cospi(right / 180)
    }
}

class ScientificCalculatorTanCommand: ScientificCalculatorCommand {
    override func previousNumberType() -> CalculatorCommandType {
        return .optional
    }

    override func answer(left: Double, right: Double) throws -> Double {
        if right.truncatingRemainder(dividingBy: 180) == 90 {
            throw CalculatorCommandError.invalidTail
        }
        return left * __tanpi(right / 180)
    }
}
