//
//  ScientificCalculatorCommand.swift
//  ScientificCalculator
//
//  Created by Jacky Lam on 2023-11-20.
//

open class ScientificCalculatorCommand: CalculatorCommand {
    func execute(node: CalculatorKeyNode) throws -> CalculatorCommandResult {
        let head = try previousNumberHead(of: node)
        let left = try previousNumber(from: head, before: node)
        let tail = try nextNumberTail(of: node)
        let right = try nextNumber(after: node, to: tail)
        let answer = try answer(left: left, right: right)
        let newKeys = CalculatorKeyConverter().convertKeys(from: answer)
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
                throw CalculatorCommandError.invalidHead
            }
            return node
        case .optional:
            return CalculatorKeyTraveler().prevNumberHead(of: node) ?? node
        case .notExist:
            guard let _ = CalculatorKeyTraveler().prevNumberHead(of: node) else {
                return node
            }
            throw CalculatorCommandError.invalidHead
        }
    }

    func previousNumber(from head: CalculatorKeyNode, before node: CalculatorKeyNode) throws -> Double {
        switch previousNumberType() {
        case .exist:
            guard let tail = node.prev else {
                throw CalculatorCommandError.invalidHead
            }
            return try number(from: head, to: tail)
        case .optional:
            guard let tail = node.prev else {
                return CalculatorCommandType.defaultNumber
            }
            return try number(from: head, to: tail)
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
                throw CalculatorCommandError.invalidTail
            }
            return node
        case .optional:
            return CalculatorKeyTraveler().nextNumberTail(of: node) ?? node
        case .notExist:
            guard let _ = CalculatorKeyTraveler().nextNumberTail(of: node) else {
                return node
            }
            throw CalculatorCommandError.invalidTail
        }
    }

    func nextNumber(after node: CalculatorKeyNode, to tail: CalculatorKeyNode) throws -> Double {
        switch nextNumberType() {
        case .exist:
            guard let head = node.next else {
                throw CalculatorCommandError.invalidTail
            }
            return try number(from: head, to: tail)
        case .optional:
            guard let head = node.next else {
                return CalculatorCommandType.defaultNumber
            }
            return try number(from: head, to: tail)
        case .notExist:
            return CalculatorCommandType.defaultNumber
        }
    }

    func answer(left: Double, right: Double) throws -> Double {
        fatalError("Please override function without super.answer(left:right:)")
    }
}
