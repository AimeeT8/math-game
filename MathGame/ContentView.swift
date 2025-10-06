//
//  ContentView.swift
//  MathGame
//
//  Created by Aimee Temple on 2025-10-01.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var board = Board(.medium)
    
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                
                Grid(horizontalSpacing: 2, verticalSpacing: 2) {
                    ForEach(0..<board.exampleCells.count, id: \.self) { row in
                        GridRow {
                            let userRow = board.userCells[row]
                            
                            ForEach(0..<userRow.count, id: \.self) { col in
                                    
                                let selected = row == board.selectedRow && col == board.selectedCol
                                
                                CellView(number: userRow[col], isSelected: selected) {
                                    board.selectedRow = row
                                    board.selectedCol = col
                                }
                            }
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
            }
            .navigationTitle("Math-Game")
        }
    }
}

#Preview {
    ContentView()
}
