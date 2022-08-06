//  Created by Alexander Skorulis on 27/7/2022.

import Foundation
import SwiftUI

enum OperationPath: Hashable, Identifiable {
    case list
    case skillRoot(_ skill: Skill)
    
    case smelting
    case construction(_ type: ConstructionSubType)
    case hr(_ type: HRSubType)
    
    var id: String {
        String(describing: self)
    }
    
    @ViewBuilder
    func render(coordinator: GameCoordinator) -> some View {
        switch self {
        case .list:
            OperationListView(viewModel: coordinator.resolve())
        case .skillRoot(let skill):
            skillView(coordinator: coordinator, skill: skill)
        case .smelting:
            SmeltingView(viewModel: coordinator.resolve())
        case .construction(let type):
            constructionView(coordinator: coordinator, type: type)
        case .hr(let type):
            hrView(coordinator: coordinator, type: type)
        }
    }
    
    @ViewBuilder
    private func skillView(coordinator: GameCoordinator, skill: Skill) -> some View {
        switch skill {
        case .mining:
            MiningView(viewModel: coordinator.resolve())
        case .metallurgy:
            MetallurgyView(viewModel: coordinator.resolve())
        case .marketing:
            MarketingView(viewModel: coordinator.resolve())
        case .construction:
            ConstructionView(viewModel: coordinator.resolve())
        case .hr:
            HumanResourcesView(viewModel: coordinator.resolve())
        }
    }
    
    @ViewBuilder
    private func constructionView(coordinator: GameCoordinator, type: ConstructionSubType) -> some View {
        switch type {
        case .materials:
            ConstructionMaterialsView(viewModel: coordinator.resolve())
        case .buildings:
            EmptyView()
        case .contracts:
            ConstructionContractsView(viewModel: coordinator.resolve())
        }
    }
    
    @ViewBuilder
    private func hrView(coordinator: GameCoordinator, type: HRSubType) -> some View {
        switch type {
        case .recruiting:
            RecruitingView(viewModel: coordinator.resolve())
        case .training:
            EducationView(viewModel: coordinator.resolve())
        }
    }
    
    
    
}
