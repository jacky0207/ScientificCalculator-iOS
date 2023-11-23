//
//  ScientificCalculatorInverseLogCommand.swift
//  
//
//  Created by Jacky Lam on 2023-11-23.
//

import Foundation

class ScientificCalculatorPowerOfTenCommand: ScientificCalculatorCommand {
    override func answer(left: Double, right: Double) throws -> Double {
        return left * pow(10, right)
    }
}

class ScientificCalculatorExponentialCommand: ScientificCalculatorCommand {
    override func answer(left: Double, right: Double) throws -> Double {
        return left * exp(right)
    }
}
