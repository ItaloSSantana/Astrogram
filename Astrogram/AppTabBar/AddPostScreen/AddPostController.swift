import UIKit

protocol AddPostDisplaying: AnyObject {
    func doSomething()
}

final class AddPostController: ViewController<AddPostInteracting, UIView> {
    private lazy var backgroundImage: UIImageView = {
      let image = UIImageView()
        image.image = UIImage(named: Constants.Images.addBackground)
        return image
    }()
    
    private lazy var addPostLabel: UILabel = {
       let label = UILabel()
        label.text = "Adicionar Postagem"
        label.numberOfLines = 1
        label.textColor = .white
        label.font = .systemFont(ofSize: 48)
        label.textAlignment = .center
        label.layer.shadowColor = UIColor(hexaRGBA: Constants.Colors.whiteColor)?.cgColor
        label.layer.shadowOffset = CGSize(width: 0, height: 0)
        label.layer.shadowOpacity = 1.0
        label.layer.shadowRadius = 14.0
        label.layer.masksToBounds = false
        return label
    }()
    
    private lazy var cardView: UIView = {
       let view = UIView()
        view.backgroundColor = UIColor(hexaRGBA: Constants.Colors.darkColor)
        return view
    }()
    
    private lazy var postImage: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    private lazy var changeImageButton: UIButton = {
       let button = UIButton()
        button.setTitle("Clique para escolher a imagem", for: .normal)
        button.titleLabel?.textColor = .white
        return button
    }()
    
    private lazy var textField = TextFieldView(title: "Legenda...")
    
    private lazy var confirmButton: CDefaultButton = {
        let button = CDefaultButton(image: Constants.Images.addButton,
                                    radius: 25, color: Constants.Colors.yellowColor,
                                    shadow: Constants.Colors.darkColor)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
    }
    
    override func buildViewHierarchy() {
        view.addSubview(backgroundImage)
        view.addSubview(addPostLabel)
        view.addSubview(cardView)
        cardView.addSubview(postImage)
        cardView.addSubview(changeImageButton)
        cardView.addSubview(textField)
        cardView.addSubview(confirmButton)
    }
    
    override func setupConstraints() {
        backgroundImage.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        addPostLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Space.base13.rawValue)
            $0.leading.trailing.equalToSuperview().inset(Space.base13.rawValue)
        }
        
        
    }
    
}

extension AddPostController: AddPostDisplaying {
    func doSomething() {
        //
    }
}
