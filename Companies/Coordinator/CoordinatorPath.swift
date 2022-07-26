//  Created by Alexander Skorulis on 26/7/2022.

import Foundation
import SwiftUI
import ASKCore

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

// -----

class CoordinatedViewModel {
    weak var coordinator: GameCoordinator!
}

enum GamePath: String, CoordinatorPath, Hashable {
    case root
    case second
    
    @ViewBuilder
    func render(coordinator: GameCoordinator) -> some View {
        switch self {
        case .root:
            NavigationLink(value: GamePath.root) {
                Text("HERE Is the first path")
            }
        case .second:
            Text("Second")
        }
    }
}

final class GameCoordinator: PCoordinator, ObservableObject {
    typealias PathType = GamePath
    
    @Published var path = NavigationPath()
    let root: GamePath
    let factory: PFactory
    
    init(factory: PFactory, root: GamePath) {
        self.root = root
        self.factory = factory
    }
    
    func push(_ p: GamePath) {
        path.append(p)
    }
    
    func pop() {
        path.removeLast()
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
        NavigationStack(path: $coordinator.path) {
            coordinator.root.render(coordinator: coordinator)
                .navigationDestination(for: GamePath.self) { path in
                    path.render(coordinator: coordinator)
                }
        }
    }
}
