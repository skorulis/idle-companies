//  Created by Alexander Skorulis on 25/7/2022.

import Foundation
import SwiftUI

// MARK: - Memory footprint

/// Background view to highlight a component
struct PanelBackground {
    
}

// MARK: - Rendering

extension PanelBackground: View {
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.background)
            Rectangle()
                .stroke(Color.highlightLine, lineWidth: 2)
            
        }
        
    }
}

// MARK: - Previews

struct PanelBackground_Previews: PreviewProvider {
    
    static var previews: some View {
        
        Text("Testing")
            .foregroundColor(.label)
            .padding(40)
            .background(PanelBackground())
        
        
    }
}

