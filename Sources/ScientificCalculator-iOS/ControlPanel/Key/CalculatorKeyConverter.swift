//
//  CalculatorKeyConverter.swift
//  ScientificCalculator
//
//  Created by Jacky Lam on 2023-11-19.
//

import Foundation

enum CalculatorKeyConverterError: Error {
    case tailNotReach
    case incorrectKeyType
    case invalidNumber
}

extension CalculatorKeyConverterError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .tailNotReach:
            return "Head should be ended with tail"
        case .incorrectKeyType:
            return "Node should be number within head and tail"
        case .invalidNumber:
            return "Invalid number nodes"
        }
    }
}

class CalculatorKeyConverter {
    func convertNumber(from head: CalculatorKeyNode, to tail: CalculatorKeyNode) throws -> Double {
        var string = ""
        var node: CalculatorKeyNode? = head
        while true {
            guard let curr = node else {
                throw CalculatorKeyConverterError.tailNotReach
            }
            switch curr.key {
            case .number(let number):
                string += number.rawValue
                node = curr.next
            case .operator(let `operator`):
                switch `operator` {
                case .plus, .minus:
                    if curr === head && curr.next == nil {  // +/- only
                        throw CalculatorKeyConverterError.incorrectKeyType
                    }
                    if let prev = curr.prev, case .number = prev.key {  // 123+45
                        throw CalculatorKeyConverterError.incorrectKeyType
                    }
                    if `operator` == .minus {  // add/remove "-"
                        if string.isEmpty {
                            string += `operator`.rawValue
                        } else {
                            _ = string.popLast()
                        }
                    }
                    node = curr.next
                case .multiply, .divide:
                    throw CalculatorKeyConverterError.incorrectKeyType
                }
            case .function:
                throw CalculatorKeyConverterError.incorrectKeyType
            case .variable:
                throw CalculatorKeyConverterError.incorrectKeyType
            case .bracket:
                throw CalculatorKeyConverterError.incorrectKeyType
            }

            if curr === tail {
                break  // end
            }
        }
        guard let number = Double(string) else {  // 123..45
            throw CalculatorKeyConverterError.invalidNumber
        }
        return number
    }

    func convertNumber(for keys: CalculatorKeyList) throws -> Double {
        guard let head = keys.head, let tail = keys.tail else {
            return 0  // empty list
        }
        return try convertNumber(from: head, to: tail)
    }

    func convertKeys(from number: Double) -> CalculatorKeyList {
        let keys = CalculatorKeyList()
        let string = number.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", number) : String(number)
        for char in string {
            if String(char) == CalculatorOperator.minus.rawValue {
                keys.append(.operator(.minus))
                continue
            }
            keys.append(CalculatorKey.number(CalculatorNumber(rawValue: "\(char)")!))
        }
        return keys
    }
}
