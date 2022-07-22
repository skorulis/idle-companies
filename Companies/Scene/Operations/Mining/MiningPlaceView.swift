//
//  MiningPlaceView.swift
//  Companies
//
//  Created by Alexander Skorulis on 21/7/2022.
//

import Foundation
import SwiftUI

// MARK: - Memory footprint

struct MiningPlaceView {
    let operation: MiningOperation
    let progress: OperationProgress?
}

// MARK: - Rendering

extension MiningPlaceView: View {
    
    var body: some View {
        VStack {
            Text(operation.name)
            PercentageOutputView(options: operation.outputPercentages)
            ActivityStatsView(activity: operation)
            OperationProgressView(timing: progress?.timing)
        }
        .frame(maxWidth: .infinity)
        .padding(2)
        .background(RoundedRectangle(cornerRadius: 8)
            .fill(backgroundColor)
        )
    }
    
    private var backgroundColor: Color {
        if progress != nil {
            return Color.green.opacity(0.1)
        } else {
            return Color.black.opacity(0.1)
        }
    }
    
}

// MARK: - Previews

struct MiningPlaceView_Previews: PreviewProvider {
    
    static var previews: some View {
        VStack {
            MiningPlaceView(operation: MiningOperation.iron, progress: nil)
        }
        .padding(12)
        
    }
}

