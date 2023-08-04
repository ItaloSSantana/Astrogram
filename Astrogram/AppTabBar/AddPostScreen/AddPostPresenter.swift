import Foundation

protocol AddPostPresenting: AnyObject {
    func savePost()
}

final class AddPostPresenter: AddPostPresenting {
    weak var viewController: AddPostDisplaying?
    private let coordinator: AddPostCoordinating
    
    init(coordinator: AddPostCoordinating) {
        self.coordinator = coordinator
    }
    
    func savePost() {
        viewController?.savePost()
    }
    
    func performAction() {
        // :- NEXT PR
    }
}
