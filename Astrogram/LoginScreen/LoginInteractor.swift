import Foundation
import FirebaseAuth
import FirebaseCore
import GoogleSignIn

protocol LoginInteracting: AnyObject {
    func loadData()
    func googlePressed()
    func registerPressed()
}

final class LoginInteractor: LoginInteracting {
    private let presenter: LoginPresenting
    var authViewModel = AuthenticationViewModel()
    
    init(presenter: LoginPresenting) {
        self.presenter = presenter
    }
    
    func loadData() {
        //
    }
    func googlePressed() {
        authViewModel.signIn()
    }
    
    func registerPressed() {
        presenter.registerPressed()
    }
}
