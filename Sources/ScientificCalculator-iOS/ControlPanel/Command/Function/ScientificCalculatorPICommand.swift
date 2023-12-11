//
//  ScientificCalculatorPICommand.swift
//  
//
//  Created by Jacky Lam on 2023-12-10.
//

class ScientificCalculatorPICommand: ScientificCalculatorCommand {
    override func nextNumberType() -> CalculatorCommandType {
        return .notExist
    }

    override func answer(left: Double, right: Double, params: [CalculatorParam: Any]) throws -> Double {
        return left * .pi
    }
}
