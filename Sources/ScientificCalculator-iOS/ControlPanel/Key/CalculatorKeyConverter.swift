//
//  CalculatorKeyConverter.swift
//  ScientificCalculator
//
//  Created by Jacky Lam on 2023-11-19.
//

import Foundation

class CalculatorKeyConverter {
    func convertNumber(from head: CalculatorKeyNode, to tail: CalculatorKeyNode) throws -> Double {
        var string = ""
        var node: CalculatorKeyNode? = head
        while true {
            guard let curr = node else {
                throw CalculatorError.syntax
            }
            switch curr.key {
            case .number(let number):
                string += number.rawValue
                node = curr.next
            case .operator(let `operator`):
                switch `operator` {
                case .plus, .minus:
                    if curr === head && curr.next == nil {  // +/- only
                        throw CalculatorError.syntax
                    }
                    if let prev = curr.prev, case .number = prev.key {  // 123+45
                        throw CalculatorError.syntax
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
                    throw CalculatorError.syntax
                }
            case .function:
                throw CalculatorError.syntax
            case .variable:
                throw CalculatorError.syntax
            case .bracket:
                throw CalculatorError.syntax
            }

            if curr === tail {
                break  // end
            }
        }
        guard let number = Double(string) else {  // 123..45
            throw CalculatorError.syntax
        }
        return number
    }

    func convertNumber(for keys: CalculatorKeyList) throws -> Double {
        guard let head = keys.head, let tail = keys.tail else {
            return 0  // empty list
        }
        return try convertNumber(from: head, to: tail)
    }

    func convertKeys(from number: Double) throws -> CalculatorKeyList {
        let keys = CalculatorKeyList()
        let string = number.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", number) : String(number)
        for char in string {
            if String(char) == CalculatorOperator.minus.rawValue {
                keys.append(.operator(.minus))
                continue
            }
            guard let number = CalculatorNumber(rawValue: "\(char)") else {
                throw CalculatorError.math
            }
            keys.append(CalculatorKey.number(number))
        }
        return keys
    }
}
