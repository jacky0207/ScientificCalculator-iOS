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

    override func answer(left: Double, right: Double, params: [CalculatorParam: Any]) throws -> Double {
        let angle = params[.angle] as? CalculatorAngle ?? .degree
        switch angle {
        case .degree:
            return left * __sinpi(right / 180)
        case .radian:
            return left * sin(right)
        }
    }
}

class ScientificCalculatorCosCommand: ScientificCalculatorCommand {
    override func previousNumberType() -> CalculatorCommandType {
        return .optional
    }

    override func answer(left: Double, right: Double, params: [CalculatorParam: Any]) throws -> Double {
        let angle = params[.angle] as? CalculatorAngle ?? .degree
        switch angle {
        case .degree:
            return left * __cospi(right / 180)
        case .radian:
            return left * cos(right)
        }
    }
}

class ScientificCalculatorTanCommand: ScientificCalculatorCommand {
    override func previousNumberType() -> CalculatorCommandType {
        return .optional
    }

    override func answer(left: Double, right: Double, params: [CalculatorParam: Any]) throws -> Double {
        if right.truncatingRemainder(dividingBy: 180) == 90 {
            throw CalculatorError.math
        }
        let angle = params[.angle] as? CalculatorAngle ?? .degree
        switch angle {
        case .degree:
            return left * __tanpi(right / 180)
        case .radian:
            return left * tan(right)
        }
    }
}
