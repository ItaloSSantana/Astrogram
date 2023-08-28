import UIKit

class AppTabBar: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBarControllers()
        setupTabBarLayout()
        setupItems()
    }
    
    func setupTabBarControllers() {
        let homeController = HomeViewFactory.make(delegate: self)
        homeController.tabBarController?.navigationItem.title = "Home"
        
        let profileController = ProfileFactory.make(delegate: self, isCurrentUser: true, userData: nil)
        profileController.tabBarController?.navigationItem.title = "Profile"
        
        let addPostController = AddPostFactory.make(delegate: self)
        addPostController.tabBarController?.navigationItem.title = "Add"
        
        let messagesController = MessagesFactory.make(delegate: self)
        messagesController.tabBarController?.navigationItem.title = "Messages"
        
        let settingsController = SettingsFactory.make(delegate: self)
        settingsController.tabBarController?.navigationItem.title = "Settings"
        
        self.setViewControllers([homeController,profileController,addPostController,messagesController,settingsController], animated: true)
    }
    
    func setupItems() {
        guard let items = self.tabBar.items else {return}
        let images = [Constants.Images.home,Constants.Images.profile, Constants.Images.add, Constants.Images.messages, Constants.Images.settings]
        
        for x in 0...images.count - 1 {
            items[x].image = UIImage(named: images[x])?.withRenderingMode(.automatic)
        }
    }
    
    func setupTabBarLayout() {
        tabBar.backgroundImage = getColoredImage(color: .clear, size: CGSize(width: view.frame.width, height: view.frame.height))
        
        self.tabBar.tintColor = UIColor(hexaRGBA: Constants.Colors.darkBlue)
        let layer = CAShapeLayer()
        layer.path = UIBezierPath(roundedRect: CGRect(x: 30, y: tabBar.bounds.minY + 5, width: tabBar.bounds.width - 60, height: tabBar.bounds.height + 10), cornerRadius: (tabBar.frame.width/2)).cgPath
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
        layer.shadowRadius = 25.0
        layer.shadowOpacity = 0.3
        layer.borderWidth = 1.0
        layer.opacity = 1.0
        layer.isHidden = false
        layer.masksToBounds = false
        layer.fillColor = UIColor.white.cgColor
        
        tabBar.layer.insertSublayer(layer, at: 0)
        
        if let items = self.tabBar.items {
            items.forEach { item in item.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: -30, right: 0) }
        }
        
        UITabBar.appearance().barTintColor = .clear
        UITabBar.appearance().layer.borderWidth = 0.0
        UITabBar.appearance().clipsToBounds = true
        
        self.tabBar.itemWidth = 30.0
        self.tabBar.itemPositioning = .centered
    }
    
    func getColoredImage(color: UIColor, size: CGSize) -> UIImage {
        let rect = CGRect(origin: CGPoint(x: 0, y: 0), size: size)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(rect)
        guard let image:UIImage = UIGraphicsGetImageFromCurrentImageContext() else { return UIImage()}
        UIGraphicsEndImageContext()
        return image
    }
}

extension AppTabBar: HomeDelegate {
    func searchPressed() {
        let searchController = SearchFactory.make(delegate: self)
        navigationController?.pushViewController(searchController, animated: true)
    }
}

extension AppTabBar: SearchDelegate {
    func returnClicked() {
        navigationController?.popViewController(animated: true)
    }
    func userPressed(user: UserDataViewModel) {
        let profileController = ProfileFactory.make(delegate: self, isCurrentUser: false, userData: user)
        navigationController?.pushViewController(profileController, animated: true)
    }
}

extension AppTabBar: ProfileDelegate {
    func continueFlow() {
        //
    }
}

extension AppTabBar: AddPostDelegate {
    
}

extension AppTabBar: MessagesDelegate {
    
}

extension AppTabBar: SettingsDelegate {
    func editProfilePressed(viewModel: UserDataViewModel) {
        let editController = EditProfileFactory.make(delegate: self, viewModel: viewModel)
        navigationController?.pushViewController(editController, animated: true)
    }
    
    func logoutPressed() {
        navigationController?.popToRootViewController(animated: true)
    }
}

extension AppTabBar: EditProfileDelegate {
    func returnPressed() {
        navigationController?.popViewController(animated: true)
    }
}
