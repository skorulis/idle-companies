//  Created by Alexander Skorulis on 23/7/2022.

import Foundation

// MARK: - Memory footprint

final class ToastPresentationService: ObservableObject {
    
    @Published private(set) var toasts: [ToastView.Model] = []
    private let appStateStore: AppStateStore
    
    init(appStateStore: AppStateStore) {
        self.appStateStore = appStateStore
    }
    
}

// MARK: - Logic

extension ToastPresentationService {
    
    func add(text: String, style: ToastView.ToastStyle) {
        if !appStateStore.inForeground { return }
        let toast = ToastView.Model(text: text, style: style)
        toasts.append(toast)
        Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { [weak self] timer in
            self?.remove(id: toast.id)
            timer.invalidate()
        }
    }
    
    private func remove(id: UUID) {
        self.toasts = self.toasts.filter { $0.id != id }
    }
}
