//  Created by Alexander Skorulis on 8/8/2022.

import ASSwiftUI
import Foundation
import SwiftUI

// MARK: - Memory footprint

struct ManageEnhancementsView {
    @StateObject var viewModel: ManageEnhancementsViewModel
}

// MARK: - Rendering

extension ManageEnhancementsView: View {
    
    var body: some View {
        PageTemplate(nav: nav, content: content)
    }
    
    private func nav() -> some View {
        NavBar(left: BarButtonItem.back(viewModel.back),
               mid: BarButtonItem.title("Enhancements"))
    }
    
    private func content() -> some View {
        VStack {
            detailItem
                .panelBackground()
            list
        }
        .padding(.horizontal, 16)
    }
    
    private var list: some View {
        ForEach(viewModel.available) { enhancement in
            listItem(enhancement)
        }
    }
    
    private func listItem(_ enhancement: Enhancement) -> some View {
        Button(action: viewModel.select(enhancement)) {
            Text(enhancement.name)
            Spacer()
            Text(viewModel.levelsString(enhancement))
        }
        
    }
    
    private var detailItem: some View {
        VStack {
            listItem(viewModel.selected)
            IngredientsView(ingredients: viewModel.currentCost,
                            inventory: viewModel.inventory)
            detailButtons
        }
    }
    
    private var detailButtons: some View {
        HStack {
            Button(action: viewModel.downgrade) {
                Text("Downgrade")
            }
            .disabled(viewModel.selectedLevel == 0)
            Spacer()
            Button(action: { viewModel.purchase(viewModel.selected) }) {
                Text("Buy")
            }
            .disabled(viewModel.selectedLevel >= viewModel.selected.maxLevel)
        }
    }
}

// MARK: - Previews

struct ManageEnhancementsView_Previews: PreviewProvider {
    
    static var previews: some View {
        let ioc = IOC()
        let coord = ioc.resolve(GameCoordinator.self, argument: GamePath.hq(.manageEnhancements))
        return CoordinatorView(coordinator: coord)
    }
}

