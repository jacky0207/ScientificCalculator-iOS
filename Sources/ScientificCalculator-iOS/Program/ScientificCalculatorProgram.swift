//
//  ScientificCalculatorProgram.swift
//  
//
//  Created by Jacky Lam on 2023-11-26.
//

public class ScientificCalculatorProgram: CalculatorProgram {
    public var name: String
    public var equations: [CalculatorProgramEquation]
    public var subEquations: [CalculatorProgramSubEquation]

    public init(
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
    public static var none: ScientificCalculatorProgram {
        return ScientificCalculatorProgram(
            name: "",
            equations: [],
            subEquations: []
        )
    }
}

public class ScientificCalculatorProgramEquation: CalculatorProgramEquation {
    public var variable: CalculatorVariable
    public var keys: CalculatorKeyList

    public init(variable: CalculatorVariable, keys: CalculatorKeyList) {
        self.variable = variable
        self.keys = keys
    }
}

extension ScientificCalculatorProgramEquation {
    public static var none: ScientificCalculatorProgramEquation {
        return ScientificCalculatorProgramEquation(
            variable: .a,
            keys: CalculatorKeyList()
        )
    }
}

public class ScientificCalculatorProgramSubEquation: CalculatorProgramSubEquation {
    public var variable: CalculatorVariable
    public var type: CalculatorProgramEquationType

    public init(variable: CalculatorVariable, type: CalculatorProgramEquationType) {
        self.variable = variable
        self.type = type
    }
}
