//  Created by Alexander Skorulis on 26/7/2022.

import Combine
import Foundation
import SwiftUI
import ASKCore

protocol PCoordinatedViewModel: AnyObject {
    var coordinator: GameCoordinator! {get set}
    var subscribers: Set<AnyCancellable> {get set}
}

class CoordinatedViewModel: PCoordinatedViewModel {
    weak var coordinator: GameCoordinator! {
        didSet {
            onCoordinatorSet()
        }
    }
    var subscribers: Set<AnyCancellable> = []
    
    func back() {
        coordinator.pop()
    }
    
    func onCoordinatorSet() { /* Overridden in children */ }
    
    lazy var inventory: InventoryStore = coordinator.resolve()
    lazy var skillStore: SkillStore = coordinator.resolve()
    lazy var xpCalc: XPLevelCalculation = coordinator.resolve()
    lazy var activityStore: ActivityStore = coordinator.resolve()
    var operations: OperationService { coordinator.resolve() }
    
    func count(_ item: ItemType) -> Int {
        inventory.count(item: item)
    }
}

final class GameCoordinator: PCoordinator, ObservableObject {
    typealias PathType = GamePath
    
    @Published var navPath = NavigationPath()
    let root: GamePath
    let factory: PFactory
    
    init(root: GamePath, factory: PFactory) {
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
