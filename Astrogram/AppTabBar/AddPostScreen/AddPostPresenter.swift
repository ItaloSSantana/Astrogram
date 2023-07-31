import Foundation

protocol AddPostPresenting: AnyObject {
    func displayScreen()
}

final class AddPostPresenter: AddPostPresenting {
    weak var viewController: AddPostDisplaying?
    private let coordinator: AddPostCoordinating
    
    init(coordinator: AddPostCoordinating) {
        self.coordinator = coordinator
    }
    
    func displayScreen() {
        viewController?.doSomething()
    }
    
    func performAction() {
        // :- NEXT PR
    }
}
