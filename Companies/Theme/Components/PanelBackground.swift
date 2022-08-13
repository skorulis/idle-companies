//  Created by Alexander Skorulis on 25/7/2022.

import Foundation
import SwiftUI

// MARK: - Memory footprint

/// Background view to highlight a component
struct PanelBackground {
 
    let selected: Bool
    
    init(selected: Bool = false) {
        self.selected = selected
    }
}

// MARK: - Rendering

extension PanelBackground: View {
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(fillColor)
            Rectangle()
                .stroke(lineColor, lineWidth: lineWidth)
            
        }
    }
    
    private var fillColor: Color {
        selected ? Color.background2 : Color.background
    }
    
    private var lineColor: Color {
        Color.highlightLine
    }
    
    private var lineWidth: CGFloat {
        selected ? 3 : 2
    }
}

extension View {
    
    func panelBackground(selected: Bool = false) -> some View {
        self.padding(4)
            .frame(maxWidth: .infinity)
            .background(PanelBackground(selected: selected))
    }
}

// MARK: - Previews

struct PanelBackground_Previews: PreviewProvider {
    
    static var previews: some View {
        
        VStack {
            Text("Testing")
                .foregroundColor(.label)
                .padding(40)
                .background(PanelBackground())
            
            Text("Testing")
                .foregroundColor(.label)
                .padding(40)
                .background(PanelBackground(selected: true))
        }
        
        
        
    }
}

