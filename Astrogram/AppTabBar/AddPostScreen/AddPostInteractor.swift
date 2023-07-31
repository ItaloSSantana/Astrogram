import Foundation

protocol AddPostInteracting: AnyObject {
    func loadData()
    func continueFlow()
}

final class AddPostInteractor: AddPostInteracting {
    let presenter: AddPostPresenting
    
    init(presenter: AddPostPresenting) {
        self.presenter = presenter
    }
    
    func loadData() {
        presenter.displayScreen()
    }
    
    func continueFlow() {
        // :- NEXT PR
    }
}
