//
//  CalculatorProgram.swift
//  
//
//  Created by Jacky Lam on 2023-11-25.
//

public protocol CalculatorProgram {
    var id: Int { get set }
    var name: String { get set }
    var equations: [CalculatorProgramEquation] { get set }
}

public protocol CalculatorProgramEquation {
    var id: Int { get set }
    var programId: Int { get set }
    var type: CalculatorProgramEquationType { get set }
    var variable: CalculatorVariable { get set }
    var keys: CalculatorKeyList { get set }
}
