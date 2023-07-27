import Foundation

protocol ProfileInteracting: AnyObject {
    func loadData()
    func continueFlow()
}

final class ProfileInteractor: ProfileInteracting {
    let presenter: ProfilePresenting
    
    init(presenter: ProfilePresenting) {
        self.presenter = presenter
    }
    
    func loadData() {
        presenter.displayScreen()
    }
    
    func continueFlow() {
        // :- NEXT PR
    }
}
