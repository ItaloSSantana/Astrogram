import UIKit

protocol EditProfileDisplaying: AnyObject {
    func loadUserData(viewModel: UserDataViewModel)
}

final class EditProfileController: ViewController<EditProfileInteracting, UIView> {
    let backgroundImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: Constants.Images.settingsBackground)
        return image
    }()
    
    private lazy var returnButton: CDefaultButton = {
        let button = CDefaultButton(image: Constants.Images.backIcon, radius: 22.5, color: Constants.Colors.darkColor, shadow: Constants.Colors.darkColor)
        button.clipsToBounds = true
        button.action = {
           self.returnPressed()
        }
        return button
    }()
    
    let userImage: UIImageView = {
       let image = UIImageView()
        image.clipsToBounds = true
        image.layer.cornerRadius = 65
        image.layer.borderWidth = 4
        image.layer.borderColor = UIColor(hexaRGBA: Constants.Colors.whiteColor)?.cgColor
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private lazy var changeImage: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(hexaRGBA: Constants.Colors.yellowColor)
        button.clipsToBounds = true
        button.layer.cornerRadius = 15
        button.setTitle("Trocar Imagem", for: .normal)
        button.titleLabel?.tintColor = .white
        button.titleLabel?.font = .systemFont(ofSize: 15)
        button.addTarget(self, action: #selector(changeImagePressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var glassView: CHGlassmorphismView = {
       let view = CHGlassmorphismView()
        view.setTheme(theme: .light)
        view.backgroundColor = .white
        view.setBlurDensity(with: 0.5)
        view.setCornerRadius(30)
        view.setDistance(15)
        return view
    }()
    
    private lazy var nameTextField = TextFieldView(title: "Insira seu novo Nome")
    
    private lazy var nickTextField = TextFieldView(title: "Insira seu novo Apelido")
    
    private lazy var emailTextField = TextFieldView(title: "Insira seu novo Email")
    
    private lazy var confirmChanges: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(hexaRGBA: Constants.Colors.yellowColor)
        button.clipsToBounds = true
        button.layer.cornerRadius = 20
        button.setTitle("Confirmar", for: .normal)
        button.titleLabel?.tintColor = .white
        button.titleLabel?.font = .systemFont(ofSize: 20)
        return button
    }()
    
    private var imagePicker = UIImagePickerController()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        interactor.loadUserData()
    }
    
    override func buildViewHierarchy() {
        view.addSubview(backgroundImage)
        view.addSubview(returnButton)
        view.addSubview(userImage)
        view.addSubview(changeImage)
        view.addSubview(glassView)
        glassView.addSubview(nameTextField)
        glassView.addSubview(nickTextField)
        glassView.addSubview(emailTextField)
        glassView.addSubview(confirmChanges)
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
        
        userImage.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(returnButton.snp.bottom).offset(Space.base06.rawValue)
            $0.height.width.equalTo(130)
        }
        
        changeImage.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(userImage.snp.bottom).offset(Space.base04.rawValue)
            $0.height.equalTo(30)
            $0.width.equalTo(120)
        }
        
        glassView.snp.makeConstraints {
            $0.top.equalTo(changeImage.snp.bottom).offset(Space.base10.rawValue)
            $0.leading.trailing.equalToSuperview().inset(Space.base06.rawValue)
        }
        
        nameTextField.snp.makeConstraints {
            $0.top.equalTo(glassView.snp.top).offset(Space.base06.rawValue)
            $0.leading.trailing.equalTo(glassView).inset(Space.base05.rawValue)
        }
        
        nickTextField.snp.makeConstraints {
            $0.top.equalTo(nameTextField.snp.bottom).offset(Space.base03.rawValue)
            $0.leading.trailing.equalTo(glassView).inset(Space.base05.rawValue)
        }
        
        emailTextField.snp.makeConstraints {
            $0.top.equalTo(nickTextField.snp.bottom).offset(Space.base03.rawValue)
            $0.leading.trailing.equalTo(glassView).inset(Space.base05.rawValue)
        }
        
        confirmChanges.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(emailTextField.snp.bottom).offset(Space.base04.rawValue)
            $0.bottom.equalTo(glassView.snp.bottom).offset(-Space.base06.rawValue)
            $0.height.equalTo(40)
            $0.width.equalTo(140)
        }
    }
    
    @objc private func returnPressed() {
        interactor.returnPressed()
    }
    
    @objc private func confirmChangesPressed() {
        interactor.saveChanges()
    }
}

extension EditProfileController: EditProfileDisplaying {
    func loadUserData(viewModel: UserDataViewModel) {
        nameTextField.setText(text: viewModel.name)
        nickTextField.setText(text: viewModel.nick)
        emailTextField.setText(text: viewModel.email)
        userImage.kf.setImage(with: URL(string: viewModel.image))
    }
}

extension EditProfileController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
   @objc private func changeImagePressed() {
        imagePicker.sourceType = .savedPhotosAlbum
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let safeImage = info [UIImagePickerController.InfoKey.originalImage] as? UIImage {
        self.userImage.image = safeImage
        imagePicker.dismiss(animated: true, completion: nil)
        }
    }
}
