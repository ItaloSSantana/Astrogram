import Foundation

protocol HomeInteracting: AnyObject {
    func loadData()
    func continueFlow()
}

final class HomeInteractor: HomeInteracting {
    let presenter: HomePresenting
    
    init(presenter: HomePresenting) {
        self.presenter = presenter
    }
    
    func loadData() {
        presenter.displayScreen()
    }
    
    func continueFlow() {
        // :- NEXT PR
    }
}
