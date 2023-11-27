//
//  ScientificCalculatorProgram.swift
//  
//
//  Created by Jacky Lam on 2023-11-26.
//

class ScientificCalculatorProgram: CalculatorProgram {
    var name: String
    var equations: [CalculatorProgramEquation]
    var subEquations: [CalculatorProgramSubEquation]

    init(
        name: String,
        equations: [CalculatorProgramEquation],
        subEquations: [CalculatorProgramSubEquation]
    ) {
        self.name = name
        self.equations = equations
        self.subEquations = subEquations
    }
}

extension ScientificCalculatorProgram {
    static var none: ScientificCalculatorProgram {
        return ScientificCalculatorProgram(
            name: "",
            equations: [],
            subEquations: []
        )
    }
}

class ScientificCalculatorProgramEquation: CalculatorProgramEquation {
    var variable: CalculatorVariable
    var keys: CalculatorKeyList

    init(variable: CalculatorVariable, keys: CalculatorKeyList) {
        self.variable = variable
        self.keys = keys
    }
}

extension ScientificCalculatorProgramEquation {
    static var none: ScientificCalculatorProgramEquation {
        return ScientificCalculatorProgramEquation(
            variable: .a,
            keys: CalculatorKeyList()
        )
    }
}

class ScientificCalculatorProgramSubEquation: CalculatorProgramSubEquation {
    var variable: CalculatorVariable
    var type: CalculatorProgramEquationType

    init(variable: CalculatorVariable, type: CalculatorProgramEquationType) {
        self.variable = variable
        self.type = type
    }
}
