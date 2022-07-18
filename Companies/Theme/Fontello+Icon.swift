//  Created by Alexander Skorulis on 18/7/2022.

import Foundation
import SwiftUI

extension Fontello {
    
    func icon(_ size: CGFloat) -> some View {
        Text(self.rawValue)
            .font(ThemeFont.fontello.font(size))
    }
    
}
