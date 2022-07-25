//  Created by Alexander Skorulis on 18/7/2022.

import Foundation
import SwiftUI

extension Color {
    
    static let label: Color = Palette.grey.step(100)
    static let background: Color = Palette.blue.step(900)
    static let background2: Color = Palette.blue.step(800)
    static let highlightLine: Color = Palette.primary.step(500)
    static let darkBackground: Color = Palette.blue.step(200)
    static let greenProgress: Color = Palette.green.step(700)
    
}

extension Color {
    
    enum Item {
        static let iron: Color = Color(0xa19d94)
        static let tin: Color = Color(0xd3d4d5)
        static let copper: Color = Color(0xb87333)
        static let gold: Color = Color(0xFFD700)
    }
}
