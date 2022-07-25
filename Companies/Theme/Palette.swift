//  Created by Alexander Skorulis on 24/7/2022.

import ASSwiftUI
import Foundation
import SwiftUI

enum Palette: UInt, PColorPalette, CaseIterable, Identifiable {
    
    case primary = 0xfdd978
    case green = 0x63806a
    case blue = 0xb0bec5
    case red = 0x7f4536
    case grey = 0xaaaaaa
    
    var color: Color {
        Color(rawValue)
    }
    
    var name: String {
        String(describing: self)
    }
    
    var id: UInt { rawValue }
    
}

struct Palette_Previews: PreviewProvider {
    
    static var previews: some View {
        ForEach(Palette.allCases) { base in
            palette(base: base)
        }
    }
    
    static var steps: [Int] {
        return [0, 100, 200, 300, 400, 500, 600, 700, 800, 900, 1000]
    }
    
    static func palette(base: Palette) -> some View {
        VStack {
            Text(base.name)
            ForEach(steps, id: \.self) { step in
                ZStack {
                    base.step(step)
                    Text("\(step)")
                }
                .frame(height: 20)
            }
        }
    }
    
}
