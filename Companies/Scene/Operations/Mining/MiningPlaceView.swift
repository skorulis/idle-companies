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
    let operation: MiningActivity
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
        .padding(4)
        .background(PanelBackground())
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
            MiningPlaceView(operation: MiningActivity.iron, progress: nil)
        }
        .padding(12)
        
    }
}

