import UIKit

protocol ProfileDisplaying: AnyObject {
    func dataLoaded(user: UserDataViewModel, posts: [PostViewModel])
    func validateUser(validate: Bool)
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
    
    private lazy var followButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(hexaRGBA: Constants.Colors.yellowColor)
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
        button.setTitle("Seguir", for: .normal)
        button.titleLabel?.tintColor = .white
        button.titleLabel?.font = .systemFont(ofSize: 20)
        return button
    }()
    
    private lazy var messageButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(hexaRGBA: Constants.Colors.yellowColor)
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
        button.setTitle("Mensagens", for: .normal)
        button.titleLabel?.tintColor = .white
        button.titleLabel?.font = .systemFont(ofSize: 20)
        return button
    }()
    
    private lazy var postsCollection: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: 106, height: 106)
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 15
        let collectionview = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionview.showsHorizontalScrollIndicator = false
        collectionview.dataSource = self
        collectionview.delegate = self
        collectionview.register(ProfilePostsCell.self, forCellWithReuseIdentifier: ProfilePostsCell.identifier)
        collectionview.showsVerticalScrollIndicator = false
        collectionview.backgroundColor = .clear
        return collectionview
    }()
    
    private lazy var returnButton: CDefaultButton = {
        let button = CDefaultButton(image: Constants.Images.backIcon,
                                    radius: 23,
                                    color: Constants.Colors.darkColor,
                                    shadow: Constants.Colors.darkColor)
        button.action = {
            self.returnPressed()
        }
        return button
    }()
    
    private var postList: [PostViewModel] = []
        
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor.validateCurrentUser()
        interactor.loadData()
        view.backgroundColor = .yellow
        
    }
    
    override func buildViewHierarchy() {
        view.addSubview(backgroundImage)
        view.addSubview(returnButton)
        view.addSubview(nameLabel)
        view.addSubview(userImage)
        view.addSubview(nickLabel)
        view.addSubview(horizontalStack)
        horizontalStack.addArrangedSubview(postsLabel)
        horizontalStack.addArrangedSubview(firstLineView)
        horizontalStack.addArrangedSubview(followersLabel)
        horizontalStack.addArrangedSubview(secondLineView)
        horizontalStack.addArrangedSubview(followingLabel)
        view.addSubview(followButton)
        view.addSubview(messageButton)
        view.addSubview(postsCollection)
    }
    
    override func setupConstraints() {
        backgroundImage.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        returnButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Space.base06.rawValue)
            $0.leading.equalToSuperview().offset(Space.base04.rawValue)
            $0.width.height.equalTo(45)
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
        
        followButton.snp.makeConstraints {
            $0.top.equalTo(horizontalStack.snp.bottom).offset(Space.base03.rawValue)
            $0.leading.equalToSuperview().offset(Space.base11.rawValue)
            $0.height.equalTo(30)
            $0.width.equalTo(140)
        }
        
        messageButton.snp.makeConstraints {
            $0.top.equalTo(horizontalStack.snp.bottom).offset(Space.base03.rawValue)
            $0.trailing.equalToSuperview().offset(-Space.base11.rawValue)
            $0.height.equalTo(30)
            $0.width.equalTo(140)
        }
        
        postsCollection.snp.makeConstraints {
            $0.top.equalTo(messageButton.snp.bottom).offset(Space.base08.rawValue)
            $0.leading.trailing.equalToSuperview().inset(Space.base08.rawValue)
            $0.bottom.equalToSuperview()
        }
    }
    
    
    @objc private func returnPressed() {
        interactor.returnPressed()
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
    func dataLoaded(user: UserDataViewModel, posts: [PostViewModel]) {
        userImage.kf.setImage(with: URL(string: user.image))
        nameLabel.text = user.name
        nickLabel.text = user.nick
        postList = posts
        postsCollection.reloadData()
    }
    
    func validateUser(validate: Bool) {
        if validate {
            returnButton.isHidden = true
        } else {
            returnButton.isHidden = false
        }
    }
}

extension ProfileController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return postList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfilePostsCell.identifier, for: indexPath) as? ProfilePostsCell else { return UICollectionViewCell()}
        cell.setupCell(post: postList[indexPath.row])
        return cell
    }
}

