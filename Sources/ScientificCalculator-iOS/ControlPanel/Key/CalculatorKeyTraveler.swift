//
//  CalculatorKeyTraveler.swift
//  ScientificCalculator
//
//  Created by Jacky Lam on 2023-11-19.
//

class CalculatorKeyTraveler {
    func tail(of node: CalculatorKeyNode) -> CalculatorKeyNode {
        var tail = node
        while true {
            guard let next = tail.next else {
                return tail
            }
            tail = next
        }
    }

    func prevNumberHead(of node: CalculatorKeyNode) -> CalculatorKeyNode? {
        var head = node
        outer: while true {
            guard let prev = head.prev else {
                break outer
            }
            switch prev.key {
            case .number:
                head = prev
            case .operator(let `operator`):
                switch `operator` {
                case .plus, .minus:  // ++--+-12345
                    if head === node {
                        break outer  // 1"+",-,123
                    }
                    if let prev2 = prev.prev {
                        if case .number = prev2.key {
                            break outer
                        }
                        if case .bracket(let bracket) = prev2.key,
                           bracket == .openBracket || bracket == .closeBracket {
                            break outer
                        }
                    }
                    head = prev
                default:
                    break outer
                }
            case .function:
                break outer
            case .variable:
                break outer
            case .bracket:
                break outer
            }
        }
        return head === node ? nil : head
    }

    func nextNumberTail(of node: CalculatorKeyNode) -> CalculatorKeyNode? {
        var tail = node
        outer: while true {
            guard let next = tail.next else {
                break outer
            }
            switch next.key {
            case .number:
                tail = next
            case .operator(let `operator`):
                if tail !== node {
                    guard case .operator = tail.key else {  // 123"+"45
                        break outer
                    }
                }
                switch `operator` {
                case .plus, .minus:  // ++--+-12345
                    tail = next
                default:
                    break outer
                }
            case .function:
                break outer
            case .variable:
                break outer
            case .bracket:
                break outer
            }
        }
        return tail === node ? nil : tail
    }
}
