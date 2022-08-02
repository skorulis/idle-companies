//  Created by Alexander Skorulis on 23/7/2022.

import Foundation
import SwiftUI

// MARK: - Memory footprint

struct ToastView {
    let model: Model
}

// MARK: - Inner Types

extension ToastView {
    enum ToastStyle {
        case positive
        case negative
    }
    
    struct Model: Identifiable, Equatable {
        let id = UUID()
        let text: String
        let style: ToastStyle
    }
}

// MARK: - Rendering

extension ToastView: View {
    
    var body: some View {
        Text(model.text)
            .bold()
            .foregroundColor(.white)
            .padding(EdgeInsets(top: 2, leading: 4, bottom: 2, trailing: 4))
            .background(background)
    }
    
    private var background: some View {
        RoundedRectangle(cornerRadius: 2)
            .fill(bgColor)
    }
    
    var bgColor: Color {
        switch model.style {
        case .negative:
            return Palette.red.step(500)
        case .positive:
            return Palette.green.step(500)
        }
    }
}

// MARK: - Previews

struct ToastView_Previews: PreviewProvider {
    
    static var previews: some View {
        let model1 = ToastView.Model(text: "+1 Iron", style: .positive)
        let model2 = ToastView.Model(text: "-1 Iron", style: .negative)
        return VStack {
            ToastView(model: model1)
            ToastView(model: model2)
        }
        
    }
}

