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
        .ignoresSafeArea(.all, edges: .top)
        .animation(.easeInOut, value: viewModel.toasts)
        .allowsHitTesting(false)
    }
}

// MARK: - Previews

struct ToastPresentationView_Previews: PreviewProvider {
    
    static var previews: some View {
        let ioc = IOC()
        let service: ToastPresentationService = ioc.resolve()
        service.add(text: "+1 Stuff", style: .positive)
        service.add(text: "+2 Other", style: .negative)
        return ToastPresentationView(viewModel: service)
    }
}


