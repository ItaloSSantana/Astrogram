import Foundation

protocol LoginPresenting: AnyObject {
    func registerPressed()
    func updateScreen()
    func loginPressed()
    func confirmLogin()
    func confirmAutoLogin()
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
    
    func confirmLogin() {
        coordinator.confirmLogin()
    }
    
    func confirmAutoLogin() {
        coordinator.confirmAutoLogin()
    }
}
