//
//  ScientificCalculator.swift
//  ScientificCalculator
//
//  Created by Jacky Lam on 2023-11-19.
//

class ScientificCalculator: Calculator {
    private(set) var mode: CalculatorMode = .default {
        didSet {
            clearAll()
        }
    }

    private(set) var storage: CalculatorStorage = ScientificCalculatorStorage()
    private(set) var displayScreen: CalculatorDisplayScreen = ScientificCalculatorDisplayScreen()
    private(set) var controlPanel: CalculatorControlPanel = ScientificCalculatorControlPanel()
    private(set) var programExecutor: CalculatorProgramExecutor = ScientificCalculatorProgramExecutor()

    private(set) var logHistory: CalculatorLogHistory = ScientificCalculatorLogHistory()

    var text: String {
        return displayScreen.text
    }
    var answer: Double {
        return displayScreen.answer
    }

    func appendKey(_ key: CalculatorKey) {
        controlPanel.appendKey(key, to: storage.keys)
        displayScreen.text = storage.keys.text
    }

    func setKeys(_ keys: CalculatorKeyList) {
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

    func delete() {
        controlPanel.delete(for: storage.keys)
        displayScreen.text = storage.keys.text
    }

    func clearAll() {
        controlPanel.clearAll(for: storage.keys)
        displayScreen.text = storage.keys.text
        displayScreen.answer = 0
    }

    func calculate() throws {
        switch mode {
        case .program:
            let answer = try controlPanel.calculate(for: storage.keys, with: storage.values)
            storage.values[programExecutor.equation.variable] = answer
            logHistory.append(ScientificCalculatorLog(keys: storage.keys.copy() as! CalculatorKeyList, answer: answer))
            if programExecutor.hasNextEquation() {
                setKeys(programExecutor.nextEquation().keys)
            } else {
                mode = .default
            }
        default:
            let answer = try controlPanel.calculate(for: storage.keys, with: storage.values)
            displayScreen.answer = answer
            logHistory.append(ScientificCalculatorLog(keys: storage.keys.copy() as! CalculatorKeyList, answer: answer))
        }
    }

    func calculate(to variable: CalculatorVariable) throws {
        switch mode {
        case .program:
            break  // not allow saving variable in program mode
        default:
            let answer = try controlPanel.calculate(for: storage.keys, with: storage.values)
            storage.values[variable] = answer  // save to variable
            displayScreen.answer = answer
            logHistory.append(ScientificCalculatorLog(keys: storage.keys.copy() as! CalculatorKeyList, answer: answer))
        }
    }

    func execute(for program: CalculatorProgram) {
        if program.equations.isEmpty {
            return
        }
        mode = .program
        programExecutor.setEquations(for: program)
        setKeys(programExecutor.nextEquation().keys)
    }
}
