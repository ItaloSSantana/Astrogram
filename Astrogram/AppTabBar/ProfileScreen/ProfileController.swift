import UIKit

protocol ProfileDisplaying: AnyObject {
    func doSomething()
}

final class ProfileController: ViewController<ProfileInteracting, UIView> {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
    }
}

extension ProfileController: ProfileDisplaying {
    func doSomething() {
        //
    }
}
