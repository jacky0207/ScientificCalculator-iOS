//
//  CalculatorKeyEditor.swift
//  ScientificCalculator
//
//  Created by Jacky Lam on 2023-11-20.
//

class CalculatorKeyEditor {
    func replace(
        _ keys: CalculatorKeyList,
        from head: CalculatorKeyNode,
        to tail: CalculatorKeyNode,
        with newKeys: CalculatorKeyList
    ) {
        keys.remove(from: head)
        if let head = newKeys.head {
            keys.append(from: head)
        }
        if let tailHead = tail.next {
            keys.append(from: tailHead)
        }
    }

    func replace(_ keys: CalculatorKeyList, withResult result: CalculatorCommandResult) {
        replace(keys, from: result.head, to: result.tail, with: result.newKeys)
    }
}
