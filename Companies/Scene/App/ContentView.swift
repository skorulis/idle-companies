//
//  ContentView.swift
//  Companies
//
//  Created by Alexander Skorulis on 17/7/2022.
//

import SwiftUI
import ASKCore

struct ContentView: View {
    
    @Environment(\.factory) private var factory
    
    
}

// MARK: - Rendering

extension ContentView {
    
    var body: some View {
        TabView {
            operations
                .tabItem {
                    Label("Operations", systemImage: "cart.fill")
                }
            InventoryView(viewModel: factory.resolve())
                .tabItem {
                    Label("Warehouse", systemImage: "bag.circle")
                }
        }
        
    }
    
    private var operations: some View {
        NavigationView {
            OperationListView(viewModel: factory.resolve())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
