//  Created by Alexander Skorulis on 23/7/2022.

import Foundation
import SwiftUI

// MARK: - Memory footprint

struct ToastPresentationView {
    
    @StateObject var viewModel: ToastPresentationService
}

// MARK: - Rendering

extension ToastPresentationView: View {
    
    var body: some View {
        VStack(spacing: 4) {
            Spacer()
                .frame(maxWidth: .infinity)
            ForEach(viewModel.toasts) { toast in
                ToastView(model: toast)
            }
            
        }
        .padding(.bottom, 8)
        .frame(maxHeight: .infinity)
        .ignoresSafeArea()
        .animation(.easeInOut, value: viewModel.toasts)
    }
}

// MARK: - Previews

struct ToastPresentationView_Previews: PreviewProvider {
    
    static var previews: some View {
        let service = ToastPresentationService()
        service.add(text: "+1 Stuff")
        service.add(text: "+2 Other")
        return ToastPresentationView(viewModel: service)
    }
}


