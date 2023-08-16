import UIKit

protocol SearchDelegate {
    func returnClicked()
}

protocol SearchCoordinating: AnyObject {
    var viewController: UIViewController? {get set}
    func returnPressed()
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
}
