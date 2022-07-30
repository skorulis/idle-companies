//  Created by Alexander Skorulis on 30/7/2022.

import Foundation
import SwiftUI

// MARK: - Memory footprint

struct SimpleRecipeView {
    let output: ItemType
}

// MARK: - Rendering

extension SimpleRecipeView: View {
    
    var body: some View {
        HStack {
            ItemIconView(item: output)
            Text(output.name)
                .foregroundColor(.black)
        }
    }
}

// MARK: - Previews

struct SimpleRecipeView_Previews: PreviewProvider {
    
    static var previews: some View {
        VStack {
            SimpleRecipeView(output: .brick)
            SimpleRecipeView(output: .coal)
        }
        
    }
}

