import Foundation

protocol LoginPresenting: AnyObject {
    func registerPressed()
}

final class LoginPresenter: LoginPresenting {
    weak var viewController: LoginDisplaying?
    private var coordinator: LoginCoordinating
    
    init(coordinator: LoginCoordinating) {
        self.coordinator = coordinator
    }
    
    func registerPressed() {
        coordinator.registerPressed()
    }
}
