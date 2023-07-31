import UIKit

protocol HomeDisplaying: AnyObject {
    func doSomething()
}

final class HomeController: ViewController<HomeInteracting, UIView> {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
    }
}

extension HomeController: HomeDisplaying {
    func doSomething() {
        //
    }
}
