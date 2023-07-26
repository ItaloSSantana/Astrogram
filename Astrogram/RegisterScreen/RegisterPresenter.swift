import Foundation

protocol RegisterPresenting: AnyObject {
    func displayScreen()
    func confirmTermsPressed(check: Bool)
    func returnPressed()
}

final class RegisterPresenter: RegisterPresenting {
    weak var viewController: RegisterDisplaying?
    private var coordinator: RegisterCoordinating
    
    init(coordinator: RegisterCoordinating) {
        self.coordinator = coordinator
    }
    
    func displayScreen() {
        print("registered, next screen")
    }
    
    func confirmTermsPressed(check: Bool) {
        viewController?.confirmTermsPressed(check: check)
    }
    
    func returnPressed() {
        coordinator.returnPressed()
    }
}
