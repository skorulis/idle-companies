//  Created by Alexander Skorulis on 23/8/2022.

import ASSwiftUI
import Foundation
import SwiftUI

// MARK: - Memory footprint

struct CenterPicker<Content: View> {
    
    @Binding var isPresented: Bool
    let content: () -> Content
    
    
}

// MARK: - Rendering

extension CenterPicker: View {
    
    var body: some View {
        if isPresented {
            visibleBody
        }
    }
    
    private var visibleBody: some View {
        ZStack {
            Button(action: {isPresented = false}) {
                Color.black
                    .opacity(0.1)
                    .ignoresSafeArea()
            }
            content()
        }
    }
}

// MARK: - View modifier

extension View {
    
    func centrePicker<Content: View>(isPresented: Binding<Bool>, content: @escaping () -> Content) -> some View {
        ZStack {
            self
            CenterPicker(isPresented: isPresented, content: content)
        }
    }
    
}

// MARK: - Previews

struct CenterPicker_Previews: PreviewProvider {
    
    static var previews: some View {
        StatefulPreviewWrapper(false) { value in
            ZStack {
                VStack {
                    Button(action: {value.wrappedValue = true}) {
                        Text("Show")
                    }
                }
                CenterPicker(isPresented: value) {
                    Text("Hello")
                }
            }
        }
        
    }
}

