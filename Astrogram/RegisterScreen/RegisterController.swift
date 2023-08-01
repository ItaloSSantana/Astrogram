import UIKit

protocol RegisterDisplaying: AnyObject {
    func confirmTermsPressed(check: Bool)
}

final class RegisterController: ViewController<RegisterInteracting, UIView> {
    private lazy var backgroundImage: UIImageView = {
      let image = UIImageView()
        image.image = UIImage(named: Constants.Images.backgroundRegister)
        return image
    }()
    
    private lazy var returnButton: CDefaultButton = {
        let button = CDefaultButton(image: Constants.Images.backIcon, radius: 22.5, color: Constants.Colors.darkColor, shadow: Constants.Colors.darkColor)
        button.clipsToBounds = true
        button.action = {
            self.returnTouched()
        }
        return button
    }()
    
    private lazy var createLabel: UILabel = {
       let label = UILabel()
        label.text = "Crie uma nova conta"
        label.numberOfLines = 2
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
    
    private lazy var glassView: CHGlassmorphismView = {
       let view = CHGlassmorphismView()
        view.setTheme(theme: .light)
        view.backgroundColor = .white
        view.setBlurDensity(with: 0.5)
        view.setCornerRadius(30)
        view.setDistance(15)
        return view
    }()
    
    private lazy var nameTextField = TextFieldView(title: "Insira seu Nome")
    
    private lazy var nickTextField = TextFieldView(title: "Insira seu Apelido")
    
    private lazy var emailTextField = TextFieldView(title: "Insira seu Email")
    
    private lazy var passwordTextField: TextFieldView = {
        let textfield = TextFieldView(title: "Insira sua senha")
        textfield.setSafeTextEntry()
        return textfield
    }()
    
    private lazy var confirmPasswordTextField: TextFieldView = {
        let textfield = TextFieldView(title: "Confirme sua senha")
        textfield.setSafeTextEntry()
        return textfield
    }()
    
    private lazy var termsLabel: UILabel = {
       let label = UILabel()
        label.text = "Li e concordo com os termos de uso"
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.textColor = .white
        return label
    }()
    
    private lazy var checkbox: CDefaultButton = {
        let button = CDefaultButton(image: "", radius: 8, color: Constants.Colors.whiteColor, shadow: Constants.Colors.blackColor)
        button.backgroundColor = .white
        button.clipsToBounds = true
        button.action = {
            self.confirmTermsTouched()
        }
        return button
    }()
    
    
    private lazy var registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(hexaRGBA: Constants.Colors.yellowColor)
        button.clipsToBounds = true
        button.layer.cornerRadius = 20
        button.setTitle("Registrar", for: .normal)
        button.titleLabel?.tintColor = .white
        button.titleLabel?.font = .systemFont(ofSize: 20)
        button.addTarget(self, action: #selector(registerPressed), for: .touchUpInside)
        return button
    }()
    
    private var check: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
    }
    
    override func buildViewHierarchy() {
        view.addSubview(backgroundImage)
        view.addSubview(returnButton)
        view.addSubview(createLabel)
        view.addSubview(glassView)
        glassView.addSubview(nameTextField)
        glassView.addSubview(nickTextField)
        glassView.addSubview(emailTextField)
        glassView.addSubview(passwordTextField)
        glassView.addSubview(confirmPasswordTextField)
        glassView.addSubview(checkbox)
        glassView.addSubview(termsLabel)
        glassView.addSubview(registerButton)
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
        
        createLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Space.base24.rawValue)
            $0.leading.trailing.equalToSuperview().inset(Space.base16.rawValue)
        }
        
        glassView.snp.makeConstraints {
            $0.top.equalTo(createLabel.snp.bottom).offset(Space.base16.rawValue)
            $0.leading.trailing.equalToSuperview().inset(Space.base06.rawValue)
           // $0.bottom.equalToSuperview().offset(-Space.base30.rawValue)
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
        
        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(emailTextField.snp.bottom).offset(Space.base03.rawValue)
            $0.leading.trailing.equalTo(glassView).inset(Space.base05.rawValue)
        }
        
        confirmPasswordTextField.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(Space.base03.rawValue)
            $0.leading.trailing.equalTo(glassView).inset(Space.base05.rawValue)
        }
        
        checkbox.snp.makeConstraints {
            $0.top.equalTo(confirmPasswordTextField.snp.bottom).offset(Space.base03.rawValue)
            $0.leading.equalTo(glassView).offset(Space.base12.rawValue)
            $0.width.height.equalTo(30)
        }
        
        termsLabel.snp.makeConstraints {
            $0.centerY.equalTo(checkbox.snp.centerY)
            $0.leading.equalTo(checkbox.snp.trailing).offset(Space.base03.rawValue)
            $0.trailing.equalTo(glassView.snp.trailing).offset(-Space.base12.rawValue)
        }
        
        registerButton.snp.makeConstraints {
            $0.top.equalTo(termsLabel.snp.bottom).offset(Space.base06.rawValue)
            $0.leading.trailing.equalTo(glassView).inset(Space.base20.rawValue)
            $0.bottom.equalTo(glassView.snp.bottom).offset(-Space.base04.rawValue)
            $0.height.equalTo(40)
        }
    }
    
    @objc private func registerPressed() {
        interactor.registerUser(name: nameTextField.getText(),
                                nick: nickTextField.getText(),
                                email: emailTextField.getText(),
                                password: passwordTextField.getText(),
                                confirm: confirmPasswordTextField.getText(),
                                check: check)
    }
    
    @objc private func confirmTermsTouched() {
        interactor.confirmTermsPressed(check: check)
    }
    
    @objc private func returnTouched() {
        interactor.returnPressed()
    }
}

extension RegisterController: RegisterDisplaying {
    func confirmTermsPressed(check: Bool) {
        self.check = check
        if check {
            checkbox.setImage(image: Constants.Images.checked)
        } else {
            checkbox.setImage(image: "")
        }
    }
}
