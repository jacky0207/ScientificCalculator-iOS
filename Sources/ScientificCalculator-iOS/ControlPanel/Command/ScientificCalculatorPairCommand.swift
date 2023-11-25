//
//  ScientificCalculatorPairCommand.swift
//  ScientificCalculator
//
//  Created by Jacky Lam on 2023-11-21.
//

open class ScientificCalculatorPairCommand: CalculatorPairCommand {
    func execute(from open: CalculatorKeyNode, to close: CalculatorKeyNode, convert: (CalculatorKeyList) throws -> CalculatorKeyList) throws -> CalculatorCommandResult {
        guard let head = open.next, head !== close else {
            throw CalculatorPairCommandError.invalidMiddle
        }
        var newKeys = CalculatorKeyList(head)
        newKeys.remove(from: close)
        newKeys = try convert(newKeys)
        if let prev = open.prev, case .number = prev.key {
            let oldHead = newKeys.head!
            newKeys = CalculatorKeyList(CalculatorKeyNode(key: .operator(.multiply)))
            newKeys.append(from: oldHead)
        }
        if let prev = open.prev, case .variable = prev.key {
            let oldHead = newKeys.head!
            newKeys = CalculatorKeyList(CalculatorKeyNode(key: .operator(.multiply)))
            newKeys.append(from: oldHead)
        }
        if let next = close.next, case .number = next.key {
            throw CalculatorPairCommandError.invalidClose
        }
        return CalculatorCommandResult(head: open, tail: close, newKeys: newKeys)
    }
}
