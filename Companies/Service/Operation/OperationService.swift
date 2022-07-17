//  Created by Alexander Skorulis on 17/7/2022.

import Foundation

final class OperationService: ObservableObject {
    
    @Published var active: [OperationProgress] = []
    
    func stop(_ op: OperationProgress) {
        op.timer?.invalidate()
    }
    
    func start(_ op: Operation) {
        print("Start")
        let time: TimeInterval = 1
        self.active.forEach { stop($0) }
        
        let timing = TaskTiming(startTime: Date(), duration: time)
        var prog = OperationProgress(operation: op, timing: timing, lastTick: Date())
        
        let timer: Timer = Timer.scheduledTimer(withTimeInterval: time, repeats: false) { [weak self] _ in
            print("Finished a thing")
            self?.finish(op)
            self?.start(op) // Restart
        }
        
        prog.timer = timer
        active = [prog]
    }
    
    func finish(_ op: Operation) {
        self.objectWillChange.send()
    }
}
