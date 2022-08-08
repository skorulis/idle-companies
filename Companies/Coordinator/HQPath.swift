//  Created by Alexander Skorulis on 28/7/2022.

import Foundation
import SwiftUI

enum HQPath: Hashable, Identifiable {
    case home
    case upgrade
    case manageEnhancements
    
    var id: String {
        String(describing: self)
    }
    
    @ViewBuilder
    func render(coordinator: GameCoordinator) -> some View {
        switch self {
        case .home:
            HeadquartersView(viewModel: coordinator.resolve())
        case .upgrade:
            HQUpgradeView(viewModel: coordinator.resolve())
        case .manageEnhancements:
            ManageEnhancementsView(viewModel: coordinator.resolve())
        }
    }
}
