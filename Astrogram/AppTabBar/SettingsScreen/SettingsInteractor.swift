import Foundation

protocol SettingsInteracting: AnyObject {
    func loadData()
    func editProfilePressed()
}

final class SettingsInteractor: SettingsInteracting {
    let presenter: SettingsPresenting
    
    init(presenter: SettingsPresenting) {
        self.presenter = presenter
    }
    
    func loadData() {
        presenter.displayScreen()
    }
    
    func editProfilePressed() {
        presenter.editProfilePressed()
    }
}
