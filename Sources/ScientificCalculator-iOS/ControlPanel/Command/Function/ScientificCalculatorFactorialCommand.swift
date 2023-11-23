//
//  ScientificCalculatorFactorialCommand.swift
//  ScientificCalculator
//
//  Created by Jacky Lam on 2023-11-20.
//

class ScientificCalculatorFactorialCommand: ScientificCalculatorCommand {
    override func nextNumberType() -> CalculatorCommandType {
        return .notExist
    }
    
    override func answer(left: Double, right: Double) throws -> Double {
        if left.truncatingRemainder(dividingBy: 1) != 0 {
            throw CalculatorCommandError.invalidHead
        }
        if left == 0 || left == 1 {
            return 1
        }
        let n = left < 0 ? Int(-left) : Int(left)
        var answer = left < 0 ? -1 : 1
        for i in 2...n {
            answer *= i
        }
        return Double(answer)
    }
}
