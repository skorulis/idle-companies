//  Created by Alexander Skorulis on 21/7/2022.

import Foundation
import SwiftUI

// MARK: - Memory footprint

struct MarketingView {
    
    @StateObject var viewModel: MarketingViewModel
}

// MARK: - Rendering

extension MarketingView: View {
    
    var body: some View {
        content
            .navigationTitle("Marketing")
    }
    
    private var content: some View {
        ScrollView {
            VStack {
                ForEach(viewModel.availableOptions) { type in
                    Button(action: viewModel.onPress(type)) {
                        AgencyMarketingTypeView(type: type,
                                     progress: viewModel.maybeProgress(type)
                        )
                        .contentShape(Rectangle())
                    }
                }
            }
            .padding(.horizontal, 16)
        }
    }
}

// MARK: - Previews

struct MarketingView_Previews: PreviewProvider {
    
    static var previews: some View {
        let ioc = IOC()
        MarketingView(viewModel: ioc.resolve())
    }
}

