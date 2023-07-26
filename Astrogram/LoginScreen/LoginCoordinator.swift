import UIKit

protocol LoginDelegate: AnyObject {
    func registerPressed()
}

protocol LoginCoordinating: AnyObject {
    var viewController: UIViewController? { get set }
    func confirmAutoLogin()
    func registerPressed()
}

final class LoginCoordinator: LoginCoordinating {
    var viewController: UIViewController?
    private var delegate: LoginDelegate
    
    init(delegate: LoginDelegate) {
        self.delegate = delegate
    }
    
    func confirmAutoLogin() {
        //
    }
    
    func registerPressed() {
        delegate.registerPressed()
    }
    
}
