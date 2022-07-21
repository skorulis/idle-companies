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
    let recipe: ItemRecipeOperation
    let progress: OperationProgress?
}

// MARK: - Rendering

extension MiningPlaceView: View {
    
    var body: some View {
        VStack {
            Text(recipe.recipe.name)
            outputOptions
            DurationView(time: recipe.baseTime)
            progressBar
        }
        .frame(maxWidth: .infinity)
        .padding(2)
        .background(RoundedRectangle(cornerRadius: 8)
            .fill(backgroundColor)
        )
    }
    
    private var outputOptions: some View {
        HStack {
            ForEach(recipe.recipe.outputPercentages) { item in
                ItemPercentageView(item: item)
            }
        }
    }
    
    private var backgroundColor: Color {
        if progress != nil {
            return Color.green.opacity(0.1)
        } else {
            return Color.black.opacity(0.1)
        }
    }
    
    @ViewBuilder
    private var progressBar: some View {
        OperationProgressView(timing: progress?.timing)
    }
}

// MARK: - Previews

struct MiningPlaceView_Previews: PreviewProvider {
    
    static var previews: some View {
        VStack {
            MiningPlaceView(recipe: MiningService.ironMine, progress: nil)
        }
        .padding(12)
        
    }
}

