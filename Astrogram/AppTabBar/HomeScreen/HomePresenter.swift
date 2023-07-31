import Foundation

protocol HomePresenting: AnyObject {
    func displayScreen()
}

final class HomePresenter: HomePresenting {
    weak var viewController: HomeDisplaying?
    private let coordinator: HomeCoordinating
    
    init(coordinator: HomeCoordinating) {
        self.coordinator = coordinator
    }
    
    func displayScreen() {
        viewController?.doSomething()
    }
    
    func performAction() {
        // :- NEXT PR
    }
}
