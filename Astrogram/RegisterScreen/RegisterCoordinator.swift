import UIKit

protocol RegisterDelegate: AnyObject {
    func continueFlow()
    func returnPressed()
}

protocol RegisterCoordinating: AnyObject {
    var viewController: UIViewController? { get set }
    func confirmAutoLogin()
    func returnPressed()
}

final class RegisterCoordinator: RegisterCoordinating {
    var viewController: UIViewController?
    private var delegate: RegisterDelegate
    
    init(delegate: RegisterDelegate) {
        self.delegate = delegate
    }
    
    func confirmAutoLogin() {
        //
    }
    
    func returnPressed() {
        delegate.returnPressed()
    }
    
}
