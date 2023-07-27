import UIKit

protocol HomeDelegate {
    func continueFlow()
}

protocol HomeCoordinating: AnyObject {
    var viewController: UIViewController? {get set}
    func continueFlow()
}

final class HomeCoordinator: HomeCoordinating {
    private var delegate: HomeDelegate
    var viewController: UIViewController?
    
    init(delegate: HomeDelegate) {
        self.delegate = delegate
    }
    
    func continueFlow() {
        // :- NEXT PR
    }
}
