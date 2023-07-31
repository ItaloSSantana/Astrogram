import Foundation

protocol EditProfilePresenting: AnyObject {
    func displayScreen()
    func returnPressed()
}

final class EditProfilePresenter: EditProfilePresenting {
    weak var viewController: EditProfileDisplaying?
    private let coordinator: EditProfileCoordinating
    
    init(coordinator: EditProfileCoordinating) {
        self.coordinator = coordinator
    }
    
    func displayScreen() {
        viewController?.doSomething()
    }
    
    func performAction() {
        // :- NEXT PR
    }
    
    func returnPressed() {
        coordinator.returnPressed()
    }
}
