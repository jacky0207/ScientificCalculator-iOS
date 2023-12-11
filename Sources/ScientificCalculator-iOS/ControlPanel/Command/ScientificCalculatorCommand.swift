//
//  ScientificCalculatorCommand.swift
//  ScientificCalculator
//
//  Created by Jacky Lam on 2023-11-20.
//

open class ScientificCalculatorCommand: CalculatorCommand {
    func execute(node: CalculatorKeyNode, params: [CalculatorParam: Any]) throws -> CalculatorCommandResult {
        let head = try previousNumberHead(of: node)
        let left = try previousNumber(from: head, before: node)
        let tail = try nextNumberTail(of: node)
        let right = try nextNumber(after: node, to: tail)
        let answer = try answer(left: left, right: right, params: params)
        let newKeys = try CalculatorKeyConverter().convertKeys(from: answer)
        return CalculatorCommandResult(
            head: head,
            tail: tail,
            newKeys: newKeys
        )
    }

    private func number(from head: CalculatorKeyNode, to tail: CalculatorKeyNode) throws -> Double {
        return try CalculatorKeyConverter().convertNumber(from: head, to: tail)
    }

    func previousNumberType() -> CalculatorCommandType {
        return .exist
    }

    func previousNumberHead(of node: CalculatorKeyNode) throws -> CalculatorKeyNode {
        switch previousNumberType() {
        case .exist:
            guard let node = CalculatorKeyTraveler().prevNumberHead(of: node) else {
                throw CalculatorError.syntax
            }
            return node
        case .optional:
            return CalculatorKeyTraveler().prevNumberHead(of: node) ?? node
        case .notExist:
            guard let _ = CalculatorKeyTraveler().prevNumberHead(of: node) else {
                return node
            }
            throw CalculatorError.syntax
        }
    }

    func previousNumber(from head: CalculatorKeyNode, before node: CalculatorKeyNode) throws -> Double {
        switch previousNumberType() {
        case .exist:
            return try number(from: head, to: node.prev!)  // throw in previousNumberHead(of:)
        case .optional:
            if head === node {  // no previous number but previous key may exist
                return CalculatorCommandType.defaultNumber
            }
            return try number(from: head, to: node.prev!)
        case .notExist:
            return CalculatorCommandType.defaultNumber
        }
    }

    func nextNumberType() -> CalculatorCommandType {
        return .exist
    }

    func nextNumberTail(of node: CalculatorKeyNode) throws -> CalculatorKeyNode {
        switch nextNumberType() {
        case .exist:
            guard let node = CalculatorKeyTraveler().nextNumberTail(of: node) else {
                throw CalculatorError.syntax
            }
            return node
        case .optional:
            return CalculatorKeyTraveler().nextNumberTail(of: node) ?? node
        case .notExist:
            if let next = node.next, case .number = next.key {  // don't use CalculatorKeyTraveler.nextNumberTail(of:) i.e. 2^2+1, where "+" is not a sign
                throw CalculatorError.syntax
            }
            return node
        }
    }

    func nextNumber(after node: CalculatorKeyNode, to tail: CalculatorKeyNode) throws -> Double {
        switch nextNumberType() {
        case .exist:
            return try number(from: node.next!, to: tail)  // throw in nextNumberTail(of:)
        case .optional:
            if node === tail {  // no next number but next key may exist
                return CalculatorCommandType.defaultNumber
            }
            return try number(from: node.next!, to: tail)
        case .notExist:
            return CalculatorCommandType.defaultNumber
        }
    }

    func answer(left: Double, right: Double, params: [CalculatorParam : Any]) throws -> Double {
        fatalError("Please override function without super.answer(left:right:params:)")
    }
}
