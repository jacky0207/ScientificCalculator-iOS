//
//  ScientificCalculator.swift
//  ScientificCalculator
//
//  Created by Jacky Lam on 2023-11-19.
//

import Combine
import SwiftUI

@available(macOS 10.15, *)
@available(iOS 13.0, *)
public class ScientificCalculator: Calculator {
    public init() {}

    private(set) public var mode: CalculatorMode = .default {
        didSet {
            clearAll()
        }
    }
    @Published public var calculationParams: [CalculatorParam: Any] = [
        .angle: CalculatorAngle.degree
    ]
    public var angle: Binding<CalculatorAngle> {
        return Binding(
            get: { self.calculationParams[.angle] as? CalculatorAngle ?? .degree },
            set: { self.calculationParams[.angle] = $0 }
        )
    }

    private(set) public var storage: CalculatorStorage = ScientificCalculatorStorage()
    @Published private(set) public var displayScreen: CalculatorDisplayScreen = ScientificCalculatorDisplayScreen()
    private(set) public var controlPanel: CalculatorControlPanel = ScientificCalculatorControlPanel()
    private(set) public var programExecutor: CalculatorProgramExecutor = ScientificCalculatorProgramExecutor()

    @Published private(set) public var logHistory: CalculatorLogHistory = ScientificCalculatorLogHistory()

    public var logs: [CalculatorLog] {
        return logHistory.logs
    }

    public var text: String {
        return displayScreen.text
    }
    public var answer: Double {
        return displayScreen.answer
    }

    public func appendKey(_ key: CalculatorKey) {
        controlPanel.appendKey(key, to: storage.keys)
        displayScreen.text = storage.keys.text
    }

    public func setKeys(_ keys: CalculatorKeyList) {
        clearAll()
        var node = keys.head
        outer: while true {
            guard let curr = node else {
                break outer
            }
            controlPanel.appendKey(curr.key, to: storage.keys)
            node = curr.next
        }
        displayScreen.text = storage.keys.text
    }

    public func delete() {
        controlPanel.delete(for: storage.keys)
        displayScreen.text = storage.keys.text
    }

    public func deleteAll() {
        controlPanel.clearAll(for: storage.keys)
        displayScreen.text = storage.keys.text
    }

    public func clearAll() {
        deleteAll()
        displayScreen.answer = 0
    }

    public func calculate() throws {
        if displayScreen.text.isEmpty {
            return
        }
        switch mode {
        case .program:
            let answer = try controlPanel.calculate(for: storage.keys, with: storage.values, params: calculationParams)
            storage.values[.answer] = answer  // save to answer
            storage.values[programExecutor.equation.variable] = answer
            logHistory.append(ScientificCalculatorLog(keys: storage.keys.copy() as! CalculatorKeyList, answer: answer, variable: programExecutor.equation.variable))
            if programExecutor.hasNextEquation() {
                setKeys(programExecutor.nextEquation().keys)
            } else {
                mode = .default
            }
        default:
            let answer = try controlPanel.calculate(for: storage.keys, with: storage.values, params: calculationParams)
            storage.values[.answer] = answer  // save to answer
            displayScreen.answer = answer
            logHistory.append(ScientificCalculatorLog(keys: storage.keys.copy() as! CalculatorKeyList, answer: answer, variable: .answer))
        }
    }

    public func calculate(to variable: CalculatorVariable) throws {
        if displayScreen.text.isEmpty {
            return
        }
        switch mode {
        case .program:
            break  // not allow saving variable in program mode
        default:
            let answer = try controlPanel.calculate(for: storage.keys, with: storage.values, params: calculationParams)
            storage.values[.answer] = answer  // save to answer
            storage.values[variable] = answer  // save to variable
            displayScreen.answer = answer
            logHistory.append(ScientificCalculatorLog(keys: storage.keys.copy() as! CalculatorKeyList, answer: answer, variable: variable))
        }
    }

    public func execute(for program: CalculatorProgram) {
        if program.equations.isEmpty {
            return
        }
        mode = .program
        programExecutor.setEquations(for: program)
        setKeys(programExecutor.nextEquation().keys)
    }
}
