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

    override func answer(left: Double, right: Double, params: [CalculatorParam: Any]) throws -> Double {
        let angle = params[.angle] as? CalculatorAngle ?? .degree
        switch angle {
        case .degree:
            return left * asin(right) / .pi * 180
        case .radian:
            return left * asin(right)
        }
    }
}

class ScientificCalculatorInverseCosCommand: ScientificCalculatorCommand {
    override func previousNumberType() -> CalculatorCommandType {
        return .optional
    }

    override func answer(left: Double, right: Double, params: [CalculatorParam: Any]) throws -> Double {
        let angle = params[.angle] as? CalculatorAngle ?? .degree
        switch angle {
        case .degree:
            return left * acos(right) / .pi * 180
        case .radian:
            return left * acos(right)
        }
    }
}

class ScientificCalculatorInverseTanCommand: ScientificCalculatorCommand {
    override func previousNumberType() -> CalculatorCommandType {
        return .optional
    }

    override func answer(left: Double, right: Double, params: [CalculatorParam: Any]) throws -> Double {
        let angle = params[.angle] as? CalculatorAngle ?? .degree
        switch angle {
        case .degree:
            return left * atan(right) / .pi * 180
        case .radian:
            return left * atan(right)
        }
    }
}
