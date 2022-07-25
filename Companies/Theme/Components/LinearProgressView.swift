//  Created by Alexander Skorulis on 23/7/2022.

import Foundation
import SwiftUI

// MARK: - Memory footprint

struct LinearProgressView {
 
    let progress: CGFloat
    let color: Color
    
    init(progress: CGFloat, color: Color = Color.greenProgress) {
        self.progress = progress
        self.color = color
    }
}

// MARK: - Rendering

extension LinearProgressView: View {
    
    var body: some View {
        RoundedRectangle(cornerRadius: 4)
            .fill(Color.black.opacity(0.1))
            .frame(height: 12)
            .overlay(filledOverlay)
    }
    
    private var filledOverlay: some View {
        GeometryReader { proxy in
            RoundedRectangle(cornerRadius: 4)
                .fill(color)
                .frame(width: proxy.size.width * progress)
        }
    }
}

// MARK: - Previews

struct LinearProgressView_Previews: PreviewProvider {
    
    static var previews: some View {
        VStack {
            LinearProgressView(progress: 0)
            LinearProgressView(progress: 0.5, color: .green)
            LinearProgressView(progress: 0.95)
            LinearProgressView(progress: 1)
        }
        
    }
}

