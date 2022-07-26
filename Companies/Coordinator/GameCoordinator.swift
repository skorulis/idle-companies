//  Created by Alexander Skorulis on 26/7/2022.

import Foundation
import SwiftUI
import ASKCore


class CoordinatedViewModel {
    weak var coordinator: GameCoordinator!
    
    func back() {
        coordinator.pop()
    }
}

enum GamePath: CoordinatorPath, Hashable {
    case operation(_ path: OperationPath)
    
    @ViewBuilder
    func render(coordinator: GameCoordinator) -> some View {
        switch self {
        case .operation(let path):
            path.render(coordinator: coordinator)
        }
    }
}

final class GameCoordinator: PCoordinator, ObservableObject {
    typealias PathType = GamePath
    
    @Published var navPath = NavigationPath()
    let root: GamePath
    let factory: PFactory
    
    init(factory: PFactory, root: GamePath) {
        self.root = root
        self.factory = factory
    }
    
    func push(_ p: GamePath) {
        navPath.append(p)
    }
    
    func push(_ path: OperationPath) {
        navPath.append(GamePath.operation(path))
    }
    
    func pop() {
        navPath.removeLast()
    }
}

extension GameCoordinator: PFactory {
    
    func resolve<Service, Arg1>(_ serviceType: Service.Type, argument: Arg1) -> Service {
        let obj = factory.resolve(serviceType, argument: argument)
        (obj as? CoordinatedViewModel)?.coordinator = self
        return obj
    }
    
    func resolve<Service, Arg1, Arg2>(_ serviceType: Service.Type, arguments arg1: Arg1, _ arg2: Arg2) -> Service {
        let obj = factory.resolve(serviceType, arguments: arg1, arg2)
        (obj as? CoordinatedViewModel)?.coordinator = self
        return obj
    }
    
    func resolve<Service>(_ serviceType: Service.Type) -> Service {
        let obj = factory.resolve(serviceType)
        (obj as? CoordinatedViewModel)?.coordinator = self
        return obj
    }
    
}

struct CoordinatorView: View {
    
    @StateObject var coordinator: GameCoordinator
    
    init(coordinator: GameCoordinator) {
        _coordinator = StateObject(wrappedValue: coordinator)
    }
    
    var body: some View {
        NavigationStack(path: $coordinator.navPath) {
            coordinator.root.render(coordinator: coordinator)
                .navigationDestination(for: GamePath.self) { path in
                    path.render(coordinator: coordinator)
                }
        }
    }
}