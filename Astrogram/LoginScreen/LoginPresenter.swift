import Foundation

protocol LoginPresenting: AnyObject {
    func registerPressed()
    func updateScreen()
    func loginPressed()
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
    
    func updateScreen() {
        viewController?.doSomething()
    }
    
    func loginPressed() {
        coordinator.loginPressed()
    }
}
