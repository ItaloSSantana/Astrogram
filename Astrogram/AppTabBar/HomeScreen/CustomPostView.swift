import UIKit

class CustomPostView: UIView {
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexaRGBA: Constants.Colors.darkColor)
        view.clipsToBounds = true
        view.layer.cornerRadius = 30
        return view
    }()
    
    private lazy var  userImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: Constants.Images.defaultUser)
        image.clipsToBounds = true
        image.layer.cornerRadius = 22
        image.layer.borderWidth = 2
        image.layer.borderColor = UIColor(hexaRGBA: Constants.Colors.whiteColor)?.cgColor
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private lazy var userNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 14)
        label.textAlignment = .left
        label.text = "Amigoamigo"
        return label
    }()
    
    private lazy var postImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "Melissa-McCarthy-Little-Mermaid-Premiere")
        image.clipsToBounds = true
        image.layer.cornerRadius = 20
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 14)
        label.textAlignment = .center
        label.text = "Amigoamigo legenda de teste essa aqui e uma legenda teste"
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var likeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: Constants.Images.starIcon), for: .normal)
        button.tintColor = .white
        return button
    }()
    
    private lazy var commentButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: Constants.Images.commentIcon), for: .normal)
        button.tintColor = .white
        return button
    }()
    
    private lazy var saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: Constants.Images.bookmarkIcon), for: .normal)
        button.tintColor = .white
        return button
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        buildHierarchy()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func buildHierarchy() {
        addSubview(backgroundView)
        addSubview(userImage)
        addSubview(userNameLabel)
        addSubview(postImage)
        addSubview(textLabel)
        addSubview(likeButton)
        addSubview(commentButton)
        addSubview(saveButton)
        setupConstraints()
    }
    
    private func setupConstraints() {
        backgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        userImage.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Space.base05.rawValue)
            $0.leading.equalToSuperview().offset(Space.base07.rawValue)
            $0.height.width.equalTo(44)
        }
        
        userNameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Space.base07.rawValue)
            $0.leading.equalTo(userImage.snp.trailing).offset(Space.base03.rawValue)
            $0.trailing.equalToSuperview().offset(-Space.base06.rawValue)
        }
        
        postImage.snp.makeConstraints {
            $0.top.equalTo(userImage.snp.bottom).offset(Space.base05.rawValue)
            $0.leading.trailing.equalToSuperview().inset(Space.base02.rawValue)
            $0.height.lessThanOrEqualTo(360)
        }
        
        textLabel.snp.makeConstraints {
            $0.top.equalTo(postImage.snp.bottom).offset(Space.base00.rawValue)
            $0.leading.trailing.equalToSuperview().inset(Space.base07.rawValue)
        }
        
        likeButton.snp.makeConstraints {
            $0.top.equalTo(textLabel.snp.bottom).offset(Space.none.rawValue)
            $0.leading.equalToSuperview().offset(Space.base05.rawValue)
            $0.bottom.equalToSuperview().offset(-Space.base02.rawValue)
        }
        
        commentButton.snp.makeConstraints {
            $0.centerY.equalTo(likeButton)
            $0.leading.equalTo(likeButton.snp.trailing).offset(Space.base03.rawValue)
        }
        
        saveButton.snp.makeConstraints {
            $0.centerY.equalTo(commentButton)
            $0.trailing.equalToSuperview().offset(-Space.base05.rawValue)
        }
    }	
    
    func setupView(post: PostViewModel) {
        postImage.kf.setImage(with: URL(string: post.imageURL))
        textLabel.text = post.text
        userImage.kf.setImage(with: URL(string: post.userImage))
        userNameLabel.text = post.name
        print(post.text)
    }
}
