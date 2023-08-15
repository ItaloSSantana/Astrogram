import Foundation

protocol SearchPresenting: AnyObject {
    func displayScreen()
}

final class SearchPresenter: SearchPresenting {
    weak var viewController: SearchDisplaying?
    private let coordinator: SearchCoordinating
    
    init(coordinator: SearchCoordinating) {
        self.coordinator = coordinator
    }
    
    func displayScreen() {
        viewController?.doSomething()
    }
    
    func performAction() {
        // :- NEXT PR
    }
}
