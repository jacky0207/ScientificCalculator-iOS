//
//  ScientificCalculatorInverseLogCommand.swift
//  
//
//  Created by Jacky Lam on 2023-11-23.
//

import Foundation

class ScientificCalculatorPowerOfTenCommand: ScientificCalculatorCommand {
    override func previousNumberType() -> CalculatorCommandType {
        return .optional
    }

    override func answer(left: Double, right: Double, params: [CalculatorParam: Any]) throws -> Double {
        return left * pow(10, right)
    }
}

class ScientificCalculatorExponentialCommand: ScientificCalculatorCommand {
    override func previousNumberType() -> CalculatorCommandType {
        return .optional
    }
    
    override func answer(left: Double, right: Double, params: [CalculatorParam: Any]) throws -> Double {
        return left * exp(right)
    }
}
