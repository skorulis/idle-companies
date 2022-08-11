//  Created by Alexander Skorulis on 21/7/2022.

#if DEBUG

import Foundation
import SwiftUI

// MARK: - Memory footprint

struct DebugView {
    
    @StateObject var viewModel: DebugViewModel
}

// MARK: - Rendering

extension DebugView: View {
    
    var body: some View {
        ScrollView {
            VStack {
                speed
                clearButton
                plus100Button
            }
        }
        .padding(.horizontal, 16)
        
        .navigationTitle("Debug")
    }
    
    private var speed: some View {
        Stepper("Speed: \(Int(viewModel.speed))", value: $viewModel.speed)
    }
    
    private var clearButton: some View {
        Button(action: viewModel.clearInventory) {
            Text("Clear inventory")
        }
    }
    
    private var plus100Button: some View {
        Button(action: {viewModel.addItems(100) }) {
            Text("Add 100 items")
        }
    }
}

// MARK: - Previews

struct DebugView_Previews: PreviewProvider {
    
    static var previews: some View {
        let ioc = IOC()
        DebugView(viewModel: ioc.resolve())
    }
}

#endif
