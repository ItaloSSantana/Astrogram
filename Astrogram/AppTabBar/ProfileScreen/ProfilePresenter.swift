import Foundation

protocol ProfilePresenting: AnyObject {
    func displayScreen()
}

final class ProfilePresenter: ProfilePresenting {
    weak var viewController: ProfileDisplaying?
    private let coordinator: ProfileCoordinating
    
    init(coordinator: ProfileCoordinating) {
        self.coordinator = coordinator
    }
    
    func displayScreen() {
        viewController?.doSomething()
    }
    
    func performAction() {
        // :- NEXT PR
    }
}
