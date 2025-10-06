//
//  Board.swift
//  MathGame
//
//  Created by Aimee Temple on 2025-10-01.
//

import Foundation


enum Difficulty: CaseIterable {
    case easy, medium, tricky, taxing, nightmare
}

class Board: ObservableObject {
    var exampleCells = [[Int]]()
    @Published var userCells = [[Int]]()
    
    @Published var selectedRow = 0
    @Published var selectedCol = 0
    
    // Call create function with a default init
    init(_ difficulty: Difficulty) {
        create(difficulty)
    }
    
    func create(_ difficulty: Difficulty) {
        selectedRow = 0
        selectedCol = 0
        
        let size: Int
        let maxNumber: Int
        
        switch difficulty {
        case .easy:
            size = 2
            maxNumber = 4
        case .medium:
            size = 3
            maxNumber = 4
        case .tricky:
            size = 4
            maxNumber = 4
        case .taxing:
            size = 5
            maxNumber = 6
        case .nightmare:
            size = 5
            maxNumber = 8
        
        }
        // convert the range into an array of arrays with each item inside being a random int
        exampleCells = (0..<size).map { _ in
            (0..<size).map { _ in
                Int.random(in: 1...maxNumber)
            }
        }
        
        userCells = Array(repeating: Array(repeating: 0, count: size), count: size)
    }
}
