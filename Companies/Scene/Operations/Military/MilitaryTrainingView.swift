//  Created by Alexander Skorulis on 12/8/2022.

import Foundation
import SwiftUI

// MARK: - Memory footprint

struct MilitaryTrainingView {
    @StateObject var viewModel: MilitaryTrainingViewModel
}

// MARK: - Rendering

extension MilitaryTrainingView: View {
    
    var body: some View {
        EmptyView()
    }
}

// MARK: - Previews

struct MilitaryTrainingView_Previews: PreviewProvider {
    
    static var previews: some View {
        let ioc = IOC()
        MilitaryTrainingView(viewModel: ioc.resolve())
    }
}

