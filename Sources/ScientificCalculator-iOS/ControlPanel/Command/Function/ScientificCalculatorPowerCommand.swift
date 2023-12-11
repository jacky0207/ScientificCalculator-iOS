//
//  ScientificCalculatorPowerCommand.swift
//  ScientificCalculator
//
//  Created by Jacky Lam on 2023-11-22.
//

import Foundation

class ScientificCalculatorPowerCommand: ScientificCalculatorCommand {
    override func answer(left: Double, right: Double, params: [CalculatorParam: Any]) throws -> Double {
        return pow(left, right)
    }
}

class ScientificCalculatorInverseFractionCommand: ScientificCalculatorPowerCommand {
    override func nextNumberType() -> CalculatorCommandType {
        return .notExist
    }

    override func answer(left: Double, right: Double, params: [CalculatorParam: Any]) throws -> Double {
        return pow(left, -1)
    }
}

class ScientificCalculatorSquareCommand: ScientificCalculatorPowerCommand {
    override func nextNumberType() -> CalculatorCommandType {
        return .notExist
    }

    override func answer(left: Double, right: Double, params: [CalculatorParam: Any]) throws -> Double {
        return pow(left, 2)
    }
}


class ScientificCalculatorCubeCommand: ScientificCalculatorCommand {
    override func nextNumberType() -> CalculatorCommandType {
        return .notExist
    }

    override func answer(left: Double, right: Double, params: [CalculatorParam: Any]) throws -> Double {
        return pow(left, 3)
    }
}
