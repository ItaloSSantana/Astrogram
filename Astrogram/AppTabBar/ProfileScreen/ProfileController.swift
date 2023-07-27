import UIKit

protocol ProfileDisplaying: AnyObject {
    func doSomething()
}

final class ProfileController: ViewController<ProfileInteracting, UIView> {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
    }
}

extension ProfileController: ProfileDisplaying {
    func doSomething() {
        //
    }
}
