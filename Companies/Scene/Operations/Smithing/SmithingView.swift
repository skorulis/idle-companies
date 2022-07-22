//
//  SmithingView.swift
//  Companies
//
//  Created by Alexander Skorulis on 20/7/2022.
//

import Foundation
import SwiftUI

// MARK: - Memory footprint

struct SmithingView {
    
    @StateObject var viewModel: SmithingViewModel
}

// MARK: - Rendering

extension SmithingView: View {
    
    var body: some View {
        ScrollView {
            VStack {
                maybeRecipeDetails
                Divider()
                recipeList
            }
            .padding(.horizontal, 16)
        }
        .navigationTitle("Smithing")
    }
    
    @ViewBuilder
    private var maybeRecipeDetails: some View {
        if let recipe = viewModel.selectedRecipe {
            VStack {
                SmithingActivityView(activity: recipe, progress: viewModel.maybeProgress)
                startButton(recipe: recipe)
            }
        }
    }
    
    private func startButton(recipe: SmithingActivity) -> some View {
        Button(action: viewModel.startSmithing) {
            HStack {
                Text("Create")
                DurationView(time: recipe.baseTime)
            }
        }
    }
    
    private var recipeList: some View {
        VStack {
            ForEach(viewModel.recipes) { recipe in
                recipeButton(recipe)
            }
        }
    }
    
    private func recipeButton(_ recipe: SmithingActivity) -> some View {
        Button(action: viewModel.recipePressed(recipe)) {
            SmithingActivityRowView(activity: recipe)
        }
    }
}

// MARK: - Previews

struct SmithingView_Previews: PreviewProvider {
    
    static var previews: some View {
        let ioc = IOC()
        let viewModel = ioc.resolve(SmithingViewModel.self)
        viewModel.selectedRecipe = SmithingActivity.goldBar
        return SmithingView(viewModel: viewModel)
    }
}

