//  Created by Alexander Skorulis on 20/7/2022.

import ASSwiftUI
import Foundation
import SwiftUI

// MARK: - Memory footprint

struct SmeltingView {
    
    @StateObject var viewModel: SmeltingViewModel
}

// MARK: - Rendering

extension SmeltingView: View {
    
    var body: some View {
        PageTemplate(nav: nav, content: content)
    }
    
    private func nav() -> some View {
        NavBar(left: BarButtonItem.back(),
               mid: Text("Smelting"))
    }
    
    private func content() -> some View {
        VStack {
            maybeRecipeDetails
            Divider()
            recipeList
        }
        .padding(.horizontal, 16)
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
    
    private func startButton(recipe: SmeltingActivity) -> some View {
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
    
    private func recipeButton(_ recipe: SmeltingActivity) -> some View {
        Button(action: viewModel.recipePressed(recipe)) {
            SmithingActivityRowView(activity: recipe)
        }
    }
}

// MARK: - Previews

struct SmithingView_Previews: PreviewProvider {
    
    static var previews: some View {
        let ioc = IOC()
        let viewModel = ioc.resolve(SmeltingViewModel.self)
        viewModel.selectedRecipe = SmeltingActivity.goldBar
        return SmeltingView(viewModel: viewModel)
    }
}

