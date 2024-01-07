//
//  ScientificCalculatorProgram.swift
//  
//
//  Created by Jacky Lam on 2023-11-26.
//

public class ScientificCalculatorProgram: CalculatorProgram {
    public var id: Int
    public var name: String
    public var equations: [CalculatorProgramEquation]

    public init(
        id: Int,
        name: String,
        equations: [CalculatorProgramEquation]
    ) {
        self.id = id
        self.name = name
        self.equations = equations
    }
}

extension ScientificCalculatorProgram {
    public static var none: ScientificCalculatorProgram {
        return ScientificCalculatorProgram(
            id: 0,
            name: "",
            equations: []
        )
    }
}

public class ScientificCalculatorProgramEquation: CalculatorProgramEquation {
    public var id: Int
    public var programId: Int
    public var type: CalculatorProgramEquationType
    public var variable: CalculatorVariable
    public var keys: CalculatorKeyList

    public init(
        id: Int,
        programId: Int,
        type: CalculatorProgramEquationType,
        variable: CalculatorVariable,
        keys: CalculatorKeyList
    ) {
        self.id = id
        self.programId = programId
        self.type = type
        self.variable = variable
        self.keys = keys
    }
}

extension ScientificCalculatorProgramEquation {
    public static var none: ScientificCalculatorProgramEquation {
        return ScientificCalculatorProgramEquation(
            id: 0,
            programId: 0,
            type: .main,
            variable: .a,
            keys: CalculatorKeyList()
        )
    }
}
