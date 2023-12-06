//
//  CalculatorError.swift
//  
//
//  Created by Jacky Lam on 2023-12-06.
//

import Foundation

enum CalculatorError: Error {
    case syntax
    case math
}

extension CalculatorError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .syntax:
            return "Syntax Error"
        case .math:
            return "Math Error"
        }
    }
}
