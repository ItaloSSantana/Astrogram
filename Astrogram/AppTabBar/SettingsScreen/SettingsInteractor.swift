import Foundation

protocol SettingsInteracting: AnyObject {
    func loadData()
    func continueFlow()
}

final class SettingsInteractor: SettingsInteracting {
    let presenter: SettingsPresenting
    
    init(presenter: SettingsPresenting) {
        self.presenter = presenter
    }
    
    func loadData() {
        presenter.displayScreen()
    }
    
    func continueFlow() {
        // :- NEXT PR
    }
}
