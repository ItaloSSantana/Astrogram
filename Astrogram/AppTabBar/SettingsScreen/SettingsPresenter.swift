import Foundation

protocol SettingsPresenting: AnyObject {
    func displayScreen()
}

final class SettingsPresenter: SettingsPresenting {
    weak var viewController: SettingsDisplaying?
    private let coordinator: SettingsCoordinating
    
    init(coordinator: SettingsCoordinating) {
        self.coordinator = coordinator
    }
    
    func displayScreen() {
        viewController?.doSomething()
    }
    
    func performAction() {
        // :- NEXT PR
    }
}
