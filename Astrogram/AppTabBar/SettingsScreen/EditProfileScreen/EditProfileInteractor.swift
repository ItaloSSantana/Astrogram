import Foundation

protocol EditProfileInteracting: AnyObject {
    func loadData()
    func continueFlow()
    func returnPressed()
}

final class EditProfileInteractor: EditProfileInteracting {
    let presenter: EditProfilePresenting
    
    init(presenter: EditProfilePresenting) {
        self.presenter = presenter
    }
    
    func loadData() {
        presenter.displayScreen()
    }
    
    func continueFlow() {
        // :- NEXT PR
    }
    
    func returnPressed() {
        presenter.returnPressed()
    }
}
