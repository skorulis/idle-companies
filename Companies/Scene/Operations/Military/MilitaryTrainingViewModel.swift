//  Created by Alexander Skorulis on 12/8/2022.

import Foundation

// MARK: - Memory footprint

final class MilitaryTrainingViewModel: CoordinatedViewModel, ObservableObject {
    
    @Published var selectedIndex: Int = 0 {
        didSet {
            if operations.store.isDoing(MilitaryTrainingActivity.self) {
                start()
            }
        }
    }
    @Published var inputType: ItemType = .dropout
    @Published var isSelectingInput: Bool = false
    
    override func onCoordinatorSet() {
        inventory.objectWillChange.sink { _ in
            self.objectWillChange.send()
        }
        .store(in: &subscribers)
        
        activityStore.objectWillChange.sink { _ in
            self.objectWillChange.send()
        }
        .store(in: &subscribers)
    }
}


// MARK: - Computed

extension MilitaryTrainingViewModel {
    var xp: Int64 {
        skillStore.xp(skill: .military)
    }
    
    var maybeProgress: OperationProgress? {
        return operations.store.maybeProgress(operation)
    }
    
    var operation: MilitaryTrainingActivity {
        MilitaryTrainingActivity(targetBattalion: selectedIndex, inputType: inputType)
    }
    
    var selectedInputCount: ItemCount {
        return ItemCount(type: inputType, count: count(inputType))
    }
    
    var inputOptions: [ItemType] {
        return [.dropout, .laborer, .teacher, .manager, .engineer]
    }
    
}

// MARK: - Logic

extension MilitaryTrainingViewModel {
    
    func start() {
        operations.start(operation)
    }
    
    func selectInput() {
        isSelectingInput = true
    }
    
    func selectInput(_ input: ItemType) {
        isSelectingInput = false
        inputType = input
        if operations.store.isDoing(MilitaryTrainingActivity.self) {
            start()
        }
    }
    
}
