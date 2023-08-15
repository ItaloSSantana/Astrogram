import UIKit

protocol HomeDelegate {
    func searchPressed()
}

protocol HomeCoordinating: AnyObject {
    var viewController: UIViewController? {get set}
    func searchPressed()
}

final class HomeCoordinator: HomeCoordinating {
    private var delegate: HomeDelegate
    var viewController: UIViewController?
    
    init(delegate: HomeDelegate) {
        self.delegate = delegate
    }
    
    func searchPressed() {
        delegate.searchPressed()
    }
}
