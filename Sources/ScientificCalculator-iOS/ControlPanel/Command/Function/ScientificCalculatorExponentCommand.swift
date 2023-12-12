//
//  ScientificCalculatorExponentCommand.swift
//  
//
//  Created by Jacky Lam on 2023-12-10.
//

import Foundation

class ScientificCalculatorExponentCommand: ScientificCalculatorCommand {
    override func previousNumberType() -> CalculatorCommandType {
        return .optional
    }

    override func answer(left: Double, right: Double, params: [CalculatorParam: Any]) throws -> Double {
        return left * pow(10, right)
    }
}
