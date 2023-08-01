import UIKit

protocol LoginDelegate: AnyObject {
    func registerPressed()
    func loginPressed()
    func confirmLogin()
    func confirmAutoLogin()
}

protocol LoginCoordinating: AnyObject {
    var viewController: UIViewController? { get set }
    func confirmAutoLogin()
    func registerPressed()
    func loginPressed()
    func confirmLogin()
}

final class LoginCoordinator: LoginCoordinating {
    var viewController: UIViewController?
    private var delegate: LoginDelegate
    
    init(delegate: LoginDelegate) {
        self.delegate = delegate
    }
    
    func confirmAutoLogin() {
        delegate.confirmAutoLogin()
    }
    
    func registerPressed() {
        delegate.registerPressed()
    }
    
    func loginPressed() {
        delegate.loginPressed()
    }
    
    func confirmLogin() {
        delegate.confirmLogin()
    }
    
}
