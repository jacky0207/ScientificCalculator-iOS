//
//  ScientificCalculatorLogCommand.swift
//  ScientificCalculator
//
//  Created by Jacky Lam on 2023-11-22.
//

import Foundation

class ScientificCalculatorLogCommand: ScientificCalculatorCommand {
    override func previousNumberType() -> CalculatorCommandType {
        return .optional
    }

    override func answer(left: Double, right: Double, params: [CalculatorParam: Any]) throws -> Double {
        return left * log10(right)
    }
}


class ScientificCalculatorNaturalLogCommand: ScientificCalculatorCommand {
    override func previousNumberType() -> CalculatorCommandType {
        return .optional
    }

    override func answer(left: Double, right: Double, params: [CalculatorParam: Any]) throws -> Double {
        return left * log(right)
    }
}
