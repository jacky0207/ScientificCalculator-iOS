//
//  ScientificCalculatorRootCommand.swift
//  
//
//  Created by Jacky Lam on 2023-11-23.
//

import Foundation

class ScientificCalculatorRootCommand: ScientificCalculatorCommand {
    override func previousNumberType() -> CalculatorCommandType {
        return .optional
    }

    override func answer(left: Double, right: Double) throws -> Double {
        return pow(right, 1/left)
    }
}

class ScientificCalculatorSquareRootCommand: ScientificCalculatorCommand {
    override func previousNumberType() -> CalculatorCommandType {
        return .optional
    }

    override func answer(left: Double, right: Double) throws -> Double {
        return left * sqrt(right)
    }
}

class ScientificCalculatorCubeRootCommand: ScientificCalculatorCommand {
    override func previousNumberType() -> CalculatorCommandType {
        return .optional
    }
    
    override func answer(left: Double, right: Double) throws -> Double {
        return left * cbrt(right)
    }
}
