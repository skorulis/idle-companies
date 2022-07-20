//
//  SmithingView.swift
//  Companies
//
//  Created by Alexander Skorulis on 20/7/2022.
//

import Foundation
import SwiftUI

// MARK: - Memory footprint

struct SmithingView {
    
    @StateObject var viewModel: SmithingViewModel
}

// MARK: - Rendering

extension SmithingView: View {
    
    var body: some View {
        ScrollView {
            VStack {
                
            }
        }
        .navigationTitle("Smithing")
    }
}

// MARK: - Previews

struct SmithingView_Previews: PreviewProvider {
    
    static var previews: some View {
        let ioc = IOC()
        SmithingView(viewModel: ioc.resolve())
    }
}

