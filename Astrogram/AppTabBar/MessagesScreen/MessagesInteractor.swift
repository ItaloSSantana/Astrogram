import Foundation

protocol MessagesInteracting: AnyObject {
    func loadData()
    func continueFlow()
}

final class MessagesInteractor: MessagesInteracting {
    let presenter: MessagesPresenting
    
    init(presenter: MessagesPresenting) {
        self.presenter = presenter
    }
    
    func loadData() {
        presenter.displayScreen()
    }
    
    func continueFlow() {
        // :- NEXT PR
    }
}
