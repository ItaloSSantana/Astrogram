import Foundation

protocol SearchInteracting: AnyObject {
    func loadData()
    func continueFlow()
}

final class SearchInteractor: SearchInteracting {
    let presenter: SearchPresenting
    
    init(presenter: SearchPresenting) {
        self.presenter = presenter
    }
    
    func loadData() {
        presenter.displayScreen()
    }
    
    func continueFlow() {
        // :- NEXT PR
    }
}
