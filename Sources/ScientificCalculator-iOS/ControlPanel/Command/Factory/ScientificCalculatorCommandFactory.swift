//
//  ScientificCalculatorCommandFactory.swift
//  ScientificCalculator
//
//  Created by Jacky Lam on 2023-11-20.
//

class ScientificCalculatorCommandFactory {
    static let shared = ScientificCalculatorCommandFactory()
    private init() {}

    func commandInstance(of type: CalculatorKey) -> CalculatorCommand {
        switch type {
        case .number:
            fatalError("Not supported number")
        case .operator(let `operator`):
            return operatorCommandInstance(of: `operator`)
        case .function(let function):
            return functionCommandInstance(of: function)
        case .variable:
            fatalError("Not supported number")
        }
    }

    func operatorCommandInstance(of type: CalculatorOperator) -> CalculatorCommand {
        switch type {
        case .plus:
            return ScientificCalculatorPlusCommand()
        case .minus:
            return ScientificCalculatorMinusCommand()
        case .multiply:
            return ScientificCalculatorMultiplyCommand()
        case .divide:
            return ScientificCalculatorDivideCommand()
        }
    }

    func functionCommandInstance(of type: CalculatorFunction) -> CalculatorCommand {
        switch type {
        case .factorial:
            return ScientificCalculatorFactorialCommand()
        case .power:
            return ScientificCalculatorPowerCommand()
        case .inverseFraction:
            return ScientificCalculatorInverseFractionCommand()
        case .square:
            return ScientificCalculatorSquareCommand()
        case .cube:
            return ScientificCalculatorCubeCommand()
        case .root:
            return ScientificCalculatorRootCommand()
        case .squareRoot:
            return ScientificCalculatorSquareCommand()
        case .cubeRoot:
            return ScientificCalculatorCubeRootCommand()
        case .log:
            return ScientificCalculatorLogCommand()
        case .naturalLog:
            return ScientificCalculatorNaturalLogCommand()
        case .powerOfTen:
            return ScientificCalculatorPowerOfTenCommand()
        case .exponential:
            return ScientificCalculatorExponentialCommand()
        case .sin:
            return ScientificCalculatorSinCommand()
        case .cos:
            return ScientificCalculatorCosCommand()
        case .tan:
            return ScientificCalculatorTanCommand()
        case .openBracket, .closeBracket:
            fatalError("Not supported function: \(type)")
        }
    }

    func functionPairCommandInstance(of type: CalculatorFunction) -> CalculatorPairCommand {
        switch type {
        case .factorial:
            fatalError("Not supported function: \(type)")
        case .power, .inverseFraction, .square, .cube:
            fatalError("Not supported function: \(type)")
        case .root, .squareRoot, .cubeRoot:
            fatalError("Not supported function: \(type)")
        case .log, .naturalLog:
            fatalError("Not supported function: \(type)")
        case .powerOfTen, .exponential:
            fatalError("Not supported function: \(type)")
        case .sin, .cos, .tan:
            fatalError("Not supported function: \(type)")
        case .openBracket, .closeBracket:
            return ScientificCalculatorBracketCommand()
        }
    }

    func variableCommandInstance(of type: CalculatorVariable) -> CalculatorVariableCommand {
        switch type {
        case .a, .b, .c, .d:
            return ScientificCalculatorVariableCommand()
        }
    }
}
