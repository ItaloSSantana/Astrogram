import UIKit

protocol ProfileDisplaying: AnyObject {
    func doSomething()
}

final class ProfileController: ViewController<ProfileInteracting, UIView> {
    private lazy var backgroundImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: Constants.Images.settingsBackground)
        return image
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Ryan Gosling"
        label.numberOfLines = 1
        label.textColor = .white
        label.font = .systemFont(ofSize: 28)
        label.textAlignment = .center
        label.layer.shadowColor = UIColor(hexaRGBA: Constants.Colors.whiteColor)?.cgColor
        label.layer.shadowOffset = CGSize(width: 0, height: 0)
        label.layer.shadowOpacity = 1.0
        label.layer.shadowRadius = 14.0
        label.layer.masksToBounds = false
        return label
    }()
    
    private lazy var  userImage: UIImageView = {
        let image = UIImageView()
      //  image.image = UIImage(named: Constants.Images.defaultUser)
        image.clipsToBounds = true
        image.layer.cornerRadius = 70
        image.layer.borderWidth = 4
        image.layer.borderColor = UIColor(hexaRGBA: Constants.Colors.whiteColor)?.cgColor
        image.contentMode = .scaleAspectFill
        return image
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
    
    private lazy var  postsLabel: UILabel = {
        let label = UILabel()
        setupLabel(label: label)
        return label
    }()
    
    private lazy var  followersLabel: UILabel = {
        let label = UILabel()
        setupLabel(label: label)
        return label
    }()
    
    private lazy var  followingLabel: UILabel = {
        let label = UILabel()
        setupLabel(label: label)
        return label
    }()
   
    private lazy var  firstLineView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: Constants.Images.line)
        image.layer.borderColor = UIColor(hexaRGBA: Constants.Colors.whiteColor)?.cgColor
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private lazy var  secondLineView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: Constants.Images.line)
        image.layer.borderColor = UIColor(hexaRGBA: Constants.Colors.whiteColor)?.cgColor
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private lazy var horizontalStack: UIStackView = {
       let stack = UIStackView()
        stack.spacing = 0
        stack.distribution = .fillProportionally
        stack.alignment = .fill
        stack.axis = .horizontal
        stack.backgroundColor = .clear
        return stack
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
    }
    
    override func buildViewHierarchy() {
        view.addSubview(backgroundImage)
        view.addSubview(nameLabel)
        view.addSubview(userImage)
        view.addSubview(nickLabel)
        view.addSubview(horizontalStack)
        horizontalStack.addArrangedSubview(postsLabel)
        horizontalStack.addArrangedSubview(firstLineView)
        horizontalStack.addArrangedSubview(followersLabel)
        horizontalStack.addArrangedSubview(secondLineView)
        horizontalStack.addArrangedSubview(followingLabel)
    }
    
    override func setupConstraints() {
        backgroundImage.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Space.base14.rawValue)
            $0.leading.trailing.equalToSuperview().inset(Space.base20.rawValue)
        }
        
        userImage.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(Space.base03.rawValue)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(140)
        }
        
        nickLabel.snp.makeConstraints {
            $0.top.equalTo(userImage.snp.bottom).offset(Space.base03.rawValue)
            $0.leading.trailing.equalToSuperview().inset(Space.base15.rawValue)
        }
        
        horizontalStack.snp.makeConstraints {
            $0.top.equalTo(nickLabel.snp.bottom).offset(Space.base03.rawValue)
            $0.leading.trailing.equalToSuperview().inset(Space.base00.rawValue)
            $0.height.equalTo(70)
        }
    }
    
    private func setupLabel(label: UILabel) {
        label.text = "Seguidores \n 150000"
        label.font = .systemFont(ofSize: 18)
        label.textColor = .white
        label.textAlignment = .center
        label.layer.shadowColor = UIColor(hexaRGBA: Constants.Colors.whiteColor)?.cgColor
        label.layer.shadowOffset = CGSize(width: 0, height: 0)
        label.layer.shadowOpacity = 1.0
        label.layer.shadowRadius = 14.0
        label.numberOfLines = 2
        label.layer.masksToBounds = false
    }
}

extension ProfileController: ProfileDisplaying {
    func doSomething() {
        //
    }
}
