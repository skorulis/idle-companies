//  Created by Alexander Skorulis on 18/7/2022.

import ASSwiftUI
import ASKCore
import Foundation
import SwiftUI

// MARK: - Memory footprint

struct OperationListView {
    
    @StateObject var viewModel: OperationListViewModel
    @Environment(\.factory) private var factory
}

// MARK: - Rendering

extension OperationListView: View {
    
    var body: some View {
        PageTemplate(nav: nav, content: content)
    }
    
    private func nav() -> some View {
        NavBar(left: EmptyView(),
               mid: BarButtonItem.title("Operations"))
    }
    
    private func content() -> some View {
        VStack {
            ForEach(viewModel.available) { skill in
                operationButton(skill: skill)
            }
        }
        .padding(.horizontal, 16)
    }
    
    private func operationButton(skill: Skill) -> some View {
        Button(action: viewModel.show(skill)) {
            VStack(alignment: .leading) {
                HStack {
                    skill.icon.image(24)
                    Text(skill.name)
                    Spacer()
                    Image(systemName: "chevron.right")
                }
                Text("Level \(viewModel.level(skill))")
            }
            
        }
        .foregroundColor(viewModel.isActive(skill) ? Palette.green.step(600) : Color.label)
    }
    
}

// MARK: - Previews

struct OperationListView_Previews: PreviewProvider {
    
    static var previews: some View {
        let ioc = IOC()
        let coordinator = ioc.emptyCoordinator
        OperationListView(viewModel: coordinator.resolve())
    }
}

