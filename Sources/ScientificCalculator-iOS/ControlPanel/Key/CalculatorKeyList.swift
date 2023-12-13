//
//  CalculatorKeyList.swift
//  ScientificCalculator
//
//  Created by Jacky Lam on 2023-11-19.
//

import Foundation

public class CalculatorKeyNode {
    var key: CalculatorKey
    var prev: CalculatorKeyNode?
    var next: CalculatorKeyNode?

    init(key: CalculatorKey) {
        self.key = key
    }
}

public protocol CalculatorKeyCollection {
    init(_ head: CalculatorKeyNode)
    init(_ keys: CalculatorKey...)
    func append(_ key: CalculatorKey)
}

public class CalculatorKeyList: CalculatorKeyCollection {
    private let entry: CalculatorKeyNode = CalculatorKeyNode(key: .number(.zero))
    private(set) var tail: CalculatorKeyNode?

    init() {}

    required public init(_ head: CalculatorKeyNode) {
        append(from: head)
    }

    required public init(_ keys: CalculatorKey...) {
        for key in keys {
            append(key)
        }
    }

    var head: CalculatorKeyNode? {
        return entry.next
    }

    public func append(_ key: CalculatorKey) {
        append(from: CalculatorKeyNode(key: key))
    }

    func append(from node: CalculatorKeyNode) {
        node.prev = tail
        if entry.next == nil {
            tail = entry
        }
        tail?.next = node
        tail = CalculatorKeyTraveler().tail(of: node)
    }

    var text: String {
        var text = ""
        var node = entry.next
        outer: while true {
            guard let curr = node else {
                break outer
            }
            text.append(curr.key.text)
            node = curr.next
        }
        return text
    }

    func contains(_ node: CalculatorKeyNode) -> Bool {
        var curr = head
        while curr != nil {
            if curr === node {
                return true
            }
            curr = curr?.next
        }
        return false
    }

    func removeAll() {
        entry.next = nil
        tail = nil
    }

    func remove(from node: CalculatorKeyNode) {
        if !contains(node) {
            fatalError("Node doesn't added in list")
        }
        if let prev = node.prev {
            prev.next = nil
            tail = prev
        } else {
            removeAll()
        }
    }

    func popLast() -> CalculatorKeyNode? {
        guard let tail = tail else {
            return nil
        }
        remove(from: tail)
        return tail
    }
}

// MARK: - NSCopying
extension CalculatorKeyList: NSCopying {
    public func copy(with zone: NSZone? = nil) -> Any {
        let copy = CalculatorKeyList()
        var node = self.head
        outer: while true {
            guard let curr = node else {
                break outer
            }
            copy.append(curr.key)
            node = curr.next
        }
        return copy
    }
}
