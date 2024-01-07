//
//  ScientificCalculatorProgramExecutor.swift
//  
//
//  Created by Jacky Lam on 2023-11-26.
//

class ScientificCalculatorProgramExecutor: CalculatorProgramExecutor {
    private(set) var equations: [CalculatorProgramEquation] = []
    private(set) var equation: CalculatorProgramEquation = ScientificCalculatorProgramEquation.none

    func setEquations(for program: CalculatorProgram) {
        equations.removeAll()
        equations.append(contentsOf: program.equations.filter { $0.type == .sub })
        equations.append(contentsOf: program.equations.filter { $0.type == .main })
    }

    func hasNextEquation() -> Bool {
        return !equations.isEmpty
    }

    func nextEquation() -> CalculatorProgramEquation {
        let equation = equations.removeFirst()
        self.equation = equation
        return equation
    }
}
