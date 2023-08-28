import UIKit

protocol SearchDelegate {
    func returnClicked()
    func userPressed(user: UserDataViewModel)
}

protocol SearchCoordinating: AnyObject {
    var viewController: UIViewController? {get set}
    func returnPressed()
    func userPressed(user: UserDataViewModel)
}

final class SearchCoordinator: SearchCoordinating {
    private var delegate: SearchDelegate
    var viewController: UIViewController?
    
    init(delegate: SearchDelegate) {
        self.delegate = delegate
    }
    
    func returnPressed() {
        delegate.returnClicked()
    }
    
    func userPressed(user: UserDataViewModel) {
        delegate.userPressed(user: user)
    }
}
