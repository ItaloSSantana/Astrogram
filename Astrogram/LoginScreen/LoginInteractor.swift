import Foundation
import FirebaseAuth
import FirebaseCore
import GoogleSignIn

protocol LoginInteracting: AnyObject {
    func validateLogin(email: String?, password: String?)
    func verifyLogin()
    func googlePressed()
    func registerPressed()
}

final class LoginInteractor: LoginInteracting {
    private let presenter: LoginPresenting
    var authViewModel = AuthenticationViewModel()
    
    private var auth: Auth?
    
    init(presenter: LoginPresenting) {
        self.presenter = presenter
        auth = Auth.auth()
    }
    
    func validateLogin(email: String?, password: String?) {
        guard let safeEmail = email, let safePassword = password else {return}
        auth?.signIn(withEmail: safeEmail, password: safePassword, completion: { (user, error) in
            if user != nil {
                self.presenter.confirmLogin()
            } else {
                print("Not logged")
            }
        })
    }
    
    func verifyLogin() {
        if let user = auth?.currentUser {
            self.presenter.confirmAutoLogin()
        }
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
