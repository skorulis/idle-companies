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
                
            inventory
                
        }
        
    }
    
    private var inventory: some View {
        NavigationView {
            InventoryView(viewModel: factory.resolve())
        }
        .tabItem {
            Label("Warehouse", systemImage: "archivebox")
        }
    }
    
    private var operations: some View {
        NavigationView {
            OperationListView(viewModel: factory.resolve())
        }
        .tabItem {
            Label("Operations", systemImage: "power.circle.fill")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
