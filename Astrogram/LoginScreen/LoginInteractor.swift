import Foundation
import FirebaseAuth
import FirebaseCore
import GoogleSignIn

protocol LoginInteracting: AnyObject {
    func updateScreen()
    func googlePressed()
    func registerPressed()
    func logoutPressed()
}

final class LoginInteractor: LoginInteracting {
    private let presenter: LoginPresenting
    var authViewModel = AuthenticationViewModel()
    
    init(presenter: LoginPresenting) {
        self.presenter = presenter
    }
    
    func updateScreen() {
        presenter.updateScreen()
    }
    func googlePressed() {
        authViewModel.signIn()
    }
    
    func registerPressed() {
        presenter.registerPressed()
    }
    
    func logoutPressed() {
        authViewModel.signOut()
    }
}
