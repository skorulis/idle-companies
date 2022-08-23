//  Created by Alexander Skorulis on 12/8/2022.

import ASSwiftUI
import Foundation
import SwiftUI

// MARK: - Memory footprint

struct MilitaryTrainingView {
    @StateObject var viewModel: MilitaryTrainingViewModel
}

// MARK: - Rendering

extension MilitaryTrainingView: View {
    
    var body: some View {
        PageTemplate(nav: nav, content: content)
            .centrePicker(isPresented: $viewModel.isSelectingInput) {
                inputPicker
            }
    }
    
    private func nav() -> some View {
        NavBar(left: BarButtonItem.back(viewModel.back),
               mid: BarButtonItem.title("Training"))
    }
    
    private func content() -> some View {
        VStack {
            SkillProgressView(xp: viewModel.xp, calc: viewModel.xpCalc)
            Text("Battalions")
            BattalionList(inventory: viewModel.inventory, selectedIndex: $viewModel.selectedIndex)
            OperationProgressView(timing: viewModel.maybeProgress?.timing)
            typeSelection
            startButton
        }
        .padding(.horizontal, 16)
    }
    
    private var typeSelection: some View {
        Button(action: viewModel.selectInput) {
            HStack {
                ItemCountView(item: viewModel.selectedInputCount)
                Text("Input")
                Spacer()
            }
        }
    }
    
    private var startButton: some View {
        Button(action: viewModel.start) {
            Text("Start")
        }
    }
    
    private var inputPicker: some View {
        VStack {
            ForEach(viewModel.inputOptions) { item in
                Button(action: {viewModel.selectInput(item)}) {
                    HStack {
                        ItemCountView(item: item.bundle(viewModel.count(item)))
                        Text(item.name)
                    }
                }
            }
        }
        .padding(32)
        .background(Color.white)
        .cornerRadius(10)
    }
}

// MARK: - Previews

struct MilitaryTrainingView_Previews: PreviewProvider {
    
    static var previews: some View {
        let ioc = IOC()
        
        let coordinator = ioc.emptyCoordinator
        _ = coordinator.resolve(OperationService.self) // Prevents crashing
        return MilitaryTrainingView(viewModel: coordinator.resolve())
    }
}

