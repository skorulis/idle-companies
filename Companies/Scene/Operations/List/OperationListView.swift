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
        ZStack {
            NavigationHelper.invisible(selection: $viewModel.selectedOp, destination: skillMapping(skill:))
            content
        }
        .navigationTitle("Operations")
    }
    
    private var content: some View {
        ScrollView {
            VStack {
                ForEach(viewModel.available) { skill in
                    operationButton(skill: skill)
                }
            }
            .padding(.horizontal, 16)
        }
    }
    
    private func operationButton(skill: Skill) -> some View {
        Button(action: viewModel.show(skill)) {
            skill.icon.image(24)
            Text(skill.name)
            Spacer()
            Image(systemName: "chevron.right")
        }
    }
    
    @ViewBuilder
    private func skillMapping(skill: Skill) -> some View {
        switch skill {
        case .mining:
            MiningView(viewModel: factory.resolve())
        case .smithing:
            SmithingView(viewModel: factory.resolve())
        }
    }
}

// MARK: - Previews

struct OperationListView_Previews: PreviewProvider {
    
    static var previews: some View {
        let ioc = IOC()
        OperationListView(viewModel: ioc.resolve())
    }
}

