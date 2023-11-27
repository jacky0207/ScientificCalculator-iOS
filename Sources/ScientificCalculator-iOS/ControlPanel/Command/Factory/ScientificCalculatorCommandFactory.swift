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
            fatalError("Not supported variable")
        case .bracket:
            fatalError("Not supported bracket")
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
            return ScientificCalculatorSquareRootCommand()
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
        }
    }

    func bracketPairCommandInstance(of type: CalculatorBracket) -> CalculatorPairCommand {
        switch type {
        case .openBracket, .closeBracket:
            return ScientificCalculatorBracketCommand()
        }
    }

    func variableCommandInstance(of type: CalculatorVariable) -> CalculatorVariableCommand {
        switch type {
        case .a, .b, .c, .d, .x, .y:
            return ScientificCalculatorVariableCommand()
        }
    }
}
