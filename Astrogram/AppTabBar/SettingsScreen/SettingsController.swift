import UIKit
import Kingfisher

protocol SettingsDisplaying: AnyObject {
    func loadUserData(data: UserDataViewModel)
}

final class SettingsController: ViewController<SettingsInteracting, UIView> {
    private lazy var  backgroundImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: Constants.Images.settingsBackground)
        return image
    }()
    
    private lazy var  userImage: UIImageView = {
        let image = UIImageView()
      //  image.image = UIImage(named: Constants.Images.defaultUser)
        image.clipsToBounds = true
        image.layer.cornerRadius = 65
        image.layer.borderWidth = 4
        image.layer.borderColor = UIColor(hexaRGBA: Constants.Colors.whiteColor)?.cgColor
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private lazy var logoutButton: CDefaultButton = {
        let button = CDefaultButton(image: Constants.Images.logout,
                                    radius: 21,
                                    color: Constants.Colors.yellowColor,
                                    shadow: Constants.Colors.blackColor)
        button.action = {
            self.logoutPressed()
        }
        return button
    }()
    
    private lazy var  nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Ryan Gosling"
        label.font = .systemFont(ofSize: 28)
        label.textColor = .white
        label.textAlignment = .center
        label.layer.shadowColor = UIColor(hexaRGBA: Constants.Colors.whiteColor)?.cgColor
        label.layer.shadowOffset = CGSize(width: 0, height: 0)
        label.layer.shadowOpacity = 1.0
        label.layer.shadowRadius = 14.0
        label.layer.masksToBounds = false
        return label
    }()
    
    private lazy var  nickLabel: UILabel = {
        let label = UILabel()
        label.text = "@realGosling"
        label.font = .systemFont(ofSize: 18)
        label.textColor = .white
        label.textAlignment = .center
        label.layer.shadowColor = UIColor(hexaRGBA: Constants.Colors.whiteColor)?.cgColor
        label.layer.shadowOffset = CGSize(width: 0, height: 0)
        label.layer.shadowOpacity = 1.0
        label.layer.shadowRadius = 14.0
        label.layer.masksToBounds = false
        return label
    }()
    
    private lazy var editProfile: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(hexaRGBA: Constants.Colors.yellowColor)
        button.clipsToBounds = true
        button.layer.cornerRadius = 15
        button.setTitle("Editar Perfil", for: .normal)
        button.titleLabel?.tintColor = .white
        button.titleLabel?.font = .systemFont(ofSize: 20)
        button.addTarget(self, action: #selector(editProfilePressed), for: .touchUpInside)
        return button
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        interactor.loadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .purple
    }
    
    override func buildViewHierarchy() {
        view.addSubview(backgroundImage)
        view.addSubview(logoutButton)
        view.addSubview(userImage)
        view.addSubview(nameLabel)
        view.addSubview(nickLabel)
        view.addSubview(editProfile)
    }
    
    override func setupConstraints() {
        backgroundImage.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        logoutButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Space.base13.rawValue)
            $0.trailing.equalToSuperview().offset(-Space.base06.rawValue)
            $0.height.width.equalTo(42)
        }
        
        userImage.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(logoutButton.snp.bottom).offset(Space.base06.rawValue)
            $0.height.width.equalTo(130)
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(userImage.snp.bottom).offset(Space.base00.rawValue)
            $0.centerX.equalToSuperview()
        }
        
        nickLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(Space.base00.rawValue)
            $0.centerX.equalToSuperview()
        }
        
        editProfile.snp.makeConstraints {
            $0.top.equalTo(nickLabel.snp.bottom).offset(Space.base03.rawValue)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(30)
            $0.width.equalTo(120)
        }
    }
    
    @objc private func editProfilePressed() {
        interactor.editProfilePressed()
    }
    
    @objc private func logoutPressed() {
        interactor.logoutPressed()
    }
    
}

extension SettingsController: SettingsDisplaying {
    func loadUserData(data: UserDataViewModel) {
        nameLabel.text = data.name
        nickLabel.text = data.nick
        print("here")
        userImage.kf.setImage(with: URL(string: data.image))
        print("here 2")
    }
}
