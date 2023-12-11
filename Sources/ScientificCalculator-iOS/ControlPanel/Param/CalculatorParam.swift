//
//  CalculatorParam.swift
//  
//
//  Created by Jacky Lam on 2023-12-11.
//

public enum CalculatorParam {
    case angle
}

public enum CalculatorAngle: String {
    case degree = "Deg"
    case radian = "Rad"
}

extension CalculatorAngle {
    public mutating func toggle() {
        switch self {
        case .degree:
            self = .radian
        case .radian:
            self = .degree
        }
    }
}
