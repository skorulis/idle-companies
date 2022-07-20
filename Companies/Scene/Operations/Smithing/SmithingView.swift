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
                RecipeDetailView(recipe: recipe, inv: viewModel.inventory)
                OperationProgressView(timing: viewModel.maybeProgress?.timing)
                startButton
            }
        }
    }
    
    private var startButton: some View {
        Button(action: viewModel.startSmithing) {
            Text("Start")
        }
    }
    
    private var recipeList: some View {
        VStack {
            ForEach(viewModel.recipes) { recipe in
                recipeButton(recipe)
            }
        }
    }
    
    private func recipeButton(_ recipe: ItemRecipeOperation) -> some View {
        Button(action: viewModel.recipePressed(recipe)) {
            RecipeView(recipe: recipe.recipe)
        }
    }
}

// MARK: - Previews

struct SmithingView_Previews: PreviewProvider {
    
    static var previews: some View {
        let ioc = IOC()
        let viewModel = ioc.resolve(SmithingViewModel.self)
        viewModel.selectedRecipe = SmithingService.goldBarRecipe
        return SmithingView(viewModel: viewModel)
    }
}

