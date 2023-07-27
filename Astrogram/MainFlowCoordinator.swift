import UIKit

class MainFlowCoordinator {
    let navigationController = UINavigationController()
    var rootViewController: UIViewController {
        return navigationController
    }
    
    func start() {
        let controller = LoginFactory.make(delegate: self)
        navigationController.pushViewController(controller, animated: true)
    }
}

extension MainFlowCoordinator: LoginDelegate {
    func registerPressed() {
        let controller = RegisterFactory.make(delegate: self)
        navigationController.pushViewController(controller, animated: true)
    }
    
    func loginPressed() {
        let tabController = AppTabBar()
           navigationController.pushViewController(tabController, animated: true)
    }
}

extension MainFlowCoordinator: RegisterDelegate {
    func continueFlow() {
        //
    }
    
    func returnPressed() {
        navigationController.popViewController(animated: true)
    }
}

