import Foundation

protocol SettingsInteracting: AnyObject {
    func loadData()
    func editProfilePressed()
    func logoutPressed()
}

final class SettingsInteractor: SettingsInteracting {
    let presenter: SettingsPresenting
    let authView = AuthenticationViewModel()
    
    
    init(presenter: SettingsPresenting) {
        self.presenter = presenter
    }
    
    func loadData() {
        presenter.displayScreen()
    }
    
    func editProfilePressed() {
        presenter.editProfilePressed()
    }
    
    func logoutPressed() {
        authView.signOut()
        presenter.logoutPressed()
    }
}
