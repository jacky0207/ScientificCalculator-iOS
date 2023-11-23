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
                if head !== node {
                    guard case .number = head.key else {  // "1"+12345
                        break outer
                    }
                }
                head = prev
            case .operator(let `operator`):
                switch `operator` {
                case .plus, .minus:  // ++--+-12345
                    if let prev2 = prev.prev {
                        if case .number = prev2.key {
                            break outer
                        }
                        if case .function(let function) = prev2.key,
                           function == .openBracket || function == .closeBracket {
                            break outer
                        }
                    }
                    head = prev
                default:
                    break outer
                }
            case .function:
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
            }
        }
        return tail === node ? nil : tail
    }
}
