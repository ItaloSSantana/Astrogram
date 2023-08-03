import UIKit

protocol AddPostDisplaying: AnyObject {
    func savePost()
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
        label.font = .systemFont(ofSize: 28)
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
        view.clipsToBounds = true
        view.layer.cornerRadius = 30
        return view
    }()
    
    private lazy var postImage: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.layer.cornerRadius = 30
        image.image = UIImage(named: Constants.Images.defaultUser)
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private lazy var changeImageButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Clique para escolher a imagem", for: .normal)
        button.titleLabel?.tintColor = .white
        button.addTarget(self, action: #selector(changeImagePressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var textField = TextFieldView(title: "Legenda...")
    
    private lazy var confirmButton: CDefaultButton = {
        let button = CDefaultButton(image: Constants.Images.addButton,
                                    radius: 31, color: Constants.Colors.yellowColor,
                                    shadow: Constants.Colors.darkColor)
        button.action = {
            self.confirmPressed()
        }
        return button
    }()
    
    private var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
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
            $0.top.equalToSuperview().offset(Space.base20.rawValue)
            $0.leading.trailing.equalToSuperview().inset(Space.base13.rawValue)
        }
        
        cardView.snp.makeConstraints {
            $0.top.equalTo(addPostLabel.snp.bottom).offset(Space.base10.rawValue)
            $0.leading.trailing.equalToSuperview().inset(Space.base08.rawValue)
        }
        
        postImage.snp.makeConstraints {
            $0.top.equalTo(cardView.snp.top).offset(Space.base07.rawValue)
            $0.centerX.equalTo(cardView.snp.centerX)
            $0.height.equalTo(260)
            $0.width.equalTo(270)
        }
        
        changeImageButton.snp.makeConstraints {
            $0.top.equalTo(postImage.snp.bottom).offset(Space.base01.rawValue)
            $0.leading.trailing.equalTo(cardView).inset(Space.base07.rawValue)
        }
        
        textField.snp.makeConstraints {
            $0.top.equalTo(changeImageButton.snp.bottom).offset(Space.base06.rawValue)
            $0.leading.trailing.equalTo(cardView).inset(Space.base05.rawValue)
        }
        
        confirmButton.snp.makeConstraints {
            $0.top.equalTo(textField.snp.bottom).offset(Space.base03.rawValue)
            $0.centerX.equalTo(cardView)
            $0.height.width.equalTo(62)
            $0.bottom.equalTo(cardView.snp.bottom).offset(-Space.base06.rawValue)
        }
    }
    
    @objc private func confirmPressed() {
        guard let image = postImage.image else {return}
        interactor.savePost(image: image, text: textField.getText())
    }
}

extension AddPostController: AddPostDisplaying {
    func savePost() {
        let alert = UIAlertController(title: "Postagem Feita", message: "A sua postagem foi salva no seu perfil", preferredStyle: UIAlertController.Style.alert)
              alert.addAction(UIAlertAction(title: "Confirmar", style: UIAlertAction.Style.default, handler: nil))
              self.present(alert, animated: true, completion: nil)
    }
}

extension AddPostController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
   @objc private func changeImagePressed() {
        imagePicker.sourceType = .savedPhotosAlbum
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let safeImage = info [UIImagePickerController.InfoKey.originalImage] as? UIImage {
        self.postImage.image = safeImage
        imagePicker.dismiss(animated: true, completion: nil)
        }
    }
}
