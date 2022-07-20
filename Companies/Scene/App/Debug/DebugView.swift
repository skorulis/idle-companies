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
                
            }
        }
        .navigationTitle("Debug")
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
