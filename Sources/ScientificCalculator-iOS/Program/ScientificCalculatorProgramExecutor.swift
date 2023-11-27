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
        for equation in program.subEquations {  // calculate sub equations before main equations
            equations.append(ScientificCalculatorProgramEquation(
                variable: equation.variable,
                keys: equation.type.keys ?? CalculatorKeyList()
            ))
        }
        equations.append(contentsOf: program.equations)
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
