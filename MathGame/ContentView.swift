//
//  ContentView.swift
//  MathGame
//
//  Created by Aimee Temple on 2025-10-01.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var board = Board(.easy)
    @State private var isGameOver = false
    
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                
                Grid(horizontalSpacing: 2, verticalSpacing: 2) {
                    ForEach(0..<board.exampleCells.count, id: \.self) { row in
                        GridRow {
                            let exampleRow = board.exampleCells[row]
                            let userRow = board.userCells[row]
                            
                            ForEach(0..<userRow.count, id: \.self) { col in
                                    
                                let selected = row == board.selectedRow && col == board.selectedCol
                                
                                CellView(number: userRow[col], isSelected: selected) {
                                    board.selectedRow = row
                                    board.selectedCol = col
                                }
                            }
                            
                            let exampleSum = sum(forRow: exampleRow)
                            let userSum = sum(forRow: userRow)
                            
                            SumView(number: exampleSum)
                                .foregroundColor(exampleSum == userSum ? .primary : .red)
                        }
                    }
                    
                    GridRow {
                        ForEach(0..<board.exampleCells[0].count, id: \.self) { col in
                            let exampleSum = sum(forCol: col, in: board.exampleCells)
                            let userSum = sum(forCol: col, in: board.userCells)
                            
                            SumView(number: exampleSum)
                                .foregroundColor(exampleSum == userSum ? .primary : .red)
                        }
                    }
                }
                .padding(.horizontal)
                
                Spacer()
                
                HStack {
                    ForEach(1..<10) { i in
                        Button(String(i)) {
                            board.enter(i)
                        }
                        .frame(maxWidth: .infinity)
                        .font(.largeTitle)
                    }
                }
                .padding()
                
                Button("Submit") {
                    isGameOver = true
                }
                .buttonStyle(.borderedProminent)
                .disabled(board.isSolved == false)
                
                
                Spacer()
            }
            .navigationTitle("Math-Game")
            .toolbar {
                Button {
                    isGameOver = true
                } label: {
                    Label("Start a new game", systemImage: "plus")
                }
            }
            .alert("Start a new game", isPresented: $isGameOver) {
                ForEach(Difficulty.allCases, id:\.self) { difficulty in
                    Button(String(describing: difficulty).capitalized) {
                        startGame(difficulty)
                    }
                }
                
                Button("Cancel", role: .cancel) { }
            }
        }
    }
    
    func sum(forRow row: [Int]) -> Int {
        row.reduce(0, +)
    }
    
    func sum(forCol col: Int, in cells: [[Int]]) -> Int {
        cells.reduce(0) {
            $0 + $1[col]
        }
    }
   
    
    func startGame(_ difficulty: Difficulty) {
        isGameOver = false
        board.create(difficulty)
    }
}

#Preview {
    ContentView()
}
