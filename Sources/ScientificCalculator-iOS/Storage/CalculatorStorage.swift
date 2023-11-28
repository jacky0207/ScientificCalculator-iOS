//
//  CalculatorStorage.swift
//  
//
//  Created by Jacky Lam on 2023-11-25.
//

public protocol CalculatorStorage {
    var keys: CalculatorKeyList { get set }
    var values: [CalculatorVariable: Double] { get set }
}
