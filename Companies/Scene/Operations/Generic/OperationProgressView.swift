//  Created by Alexander Skorulis on 17/7/2022.

import Foundation
import SwiftUI

// MARK: - Memory footprint

struct OperationProgressView {
 
    let timing: TaskTiming?
    
    @State private var progress: CGFloat
    @Environment(\.timeProvider) private var timeProvider
    
    init(timing: TaskTiming?) {
        self.timing = timing
        if let timing = timing {
            _progress = State(wrappedValue: timing.currentPct)
        } else {
            _progress = State(wrappedValue: 0)
        }
    }
}

// MARK: - Rendering

extension OperationProgressView: View {
    
    var body: some View {
        LinearProgressView(progress: progress, color: .red)
            .onAppear(perform: start)
            .id(self.id)
    }
    
}

// MARK: - Computed values

private extension OperationProgressView {
 
    var id: String {
        return timing?.id ?? "-"
    }
}

// MARK: - Logic

private extension OperationProgressView {
 
    func start() {
        guard let timing = timing else {
            self.progress = 0
            return
        }
        self.progress = timing.currentPct
        let rem = timing.remaining(timeProvider)
        if rem <= 0 {
            progress = 1
            return
        }
        
        withAnimation(.linear(duration: rem)) {
            progress = 1
        }
    }
    
}

// MARK: - Previews

struct OperationProgressView_Previews: PreviewProvider {
    
    static var previews: some View {
        VStack(spacing: 8) {
            let t1 = TaskTiming(startTime: Date(), duration: 5)
            let t2 = TaskTiming(startTime: Date().advanced(by: -3), duration: 5)
            OperationProgressView(timing: t1)
            OperationProgressView(timing: t2)
            OperationProgressView(timing: nil)
        }
        .padding()
    }
}

