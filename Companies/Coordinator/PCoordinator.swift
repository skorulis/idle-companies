//  Created by Alexander Skorulis on 27/7/2022.

import Foundation
import SwiftUI

protocol CoordinatorPath: Hashable {
    associatedtype CoordinatorType: PCoordinator where CoordinatorType.PathType == Self
    associatedtype ViewType: View
    
    func render(coordinator: CoordinatorType) -> ViewType
}

protocol PCoordinator {
    associatedtype PathType: CoordinatorPath where PathType.CoordinatorType == Self
    
    func push(_ p: PathType)
    func pop()
}
