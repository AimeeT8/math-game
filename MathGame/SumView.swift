//
//  SumView.swift
//  MathGame
//
//  Created by Aimee Temple on 2025-10-06.
//

import SwiftUI

struct SumView: View {
    @ScaledMetric(relativeTo: .title) var frameWidth = 50
    var number: Int
    
    var body: some View {
        Text(String(number))
            .font(.title)
            .monospacedDigit()
            .frame(width: frameWidth, height: frameWidth)
    }
}

#Preview {
    SumView(number: 8)
}
