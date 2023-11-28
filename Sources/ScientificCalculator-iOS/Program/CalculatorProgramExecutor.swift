//
//  CalculatorProgramExecutor.swift
//  
//
//  Created by Jacky Lam on 2023-11-26.
//

public protocol CalculatorProgramExecutor {
    var equations: [CalculatorProgramEquation] { get }
    var equation: CalculatorProgramEquation { get }
    func setEquations(for program: CalculatorProgram)
    func hasNextEquation() -> Bool
    func nextEquation() -> CalculatorProgramEquation
}
