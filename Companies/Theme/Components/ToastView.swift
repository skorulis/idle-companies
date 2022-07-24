//  Created by Alexander Skorulis on 23/7/2022.

import Foundation
import SwiftUI

// MARK: - Memory footprint

struct ToastView {
    let model: Model
}

// MARK: - Inner Types

extension ToastView {
    struct Model: Identifiable, Equatable {
        let id = UUID()
        let text: String
    }
}

// MARK: - Rendering

extension ToastView: View {
    
    var body: some View {
        Text(model.text)
            .background(Color.green)
    }
}

// MARK: - Previews

struct ToastView_Previews: PreviewProvider {
    
    static var previews: some View {
        let model = ToastView.Model(text: "+1 Iron")
        ToastView(model: model)
    }
}

