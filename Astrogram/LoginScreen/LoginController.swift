import UIKit
import SnapKit
import GoogleSignIn

protocol LoginDisplaying: AnyObject {
    func doSomething()
}

class LoginController: ViewController<LoginInteracting, UIView> {
    
    private lazy var backgroundImage: UIImageView = {
      let image = UIImageView()
        image.image = UIImage(named: Constants.Images.backgroundLogin)
        return image
    }()
    
    private lazy var logoImage: UIImageView = {
      let image = UIImageView()
        image.image = UIImage(named: Constants.Images.appLogo)
        return image
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
    
    private lazy var emailTextField = TextFieldView(title: "Insira seu Email")
    
    private lazy var passwordTextField = TextFieldView(title: "Insira sua senha")
    
    private lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(hexaRGBA: Constants.Colors.yellowColor)
        button.clipsToBounds = true
        button.layer.cornerRadius = 20
        button.setTitle("Entrar", for: .normal)
        button.titleLabel?.tintColor = .white
        button.titleLabel?.font = .systemFont(ofSize: 20)
        button.addTarget(self, action: #selector(loginPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Ainda não é registrado? Registre-se", for: .normal)
        button.titleLabel?.tintColor = .white
        button.addTarget(self, action: #selector(registerPressed), for: .touchUpInside)
        return button
    }()

    private lazy var googleButton: CustomButtonView = {
        let button = CustomButtonView(title: "Entre usando Google", image: Constants.Images.googleLogo, radius: 20)
        button.backgroundColor = .white
        button.action = {
            self.signInGoogle()
        }
        return button
    }()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor.verifyLogin()
    }
    
    override func buildViewHierarchy() {
        view.addSubview(backgroundImage)
        view.addSubview(logoImage)
        view.addSubview(glassView)
        glassView.addSubview(emailTextField)
        glassView.addSubview(passwordTextField)
        glassView.addSubview(loginButton)
        glassView.addSubview(registerButton)
        glassView.addSubview(googleButton)
    }
    
    override func setupConstraints() {
        backgroundImage.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        logoImage.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Space.base14.rawValue)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(242)
        }
        
        glassView.snp.makeConstraints {
            $0.top.equalTo(logoImage.snp.bottom).offset(Space.base11.rawValue)
            $0.leading.trailing.equalToSuperview().inset(Space.base06.rawValue)
           // $0.bottom.equalToSuperview().offset(-Space.base30.rawValue)
        }
        
        emailTextField.snp.makeConstraints {
            $0.top.equalTo(glassView.snp.top).offset(Space.base06.rawValue)
            $0.leading.trailing.equalTo(glassView).inset(Space.base05.rawValue)
        }
        
        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(emailTextField.snp.bottom).offset(Space.base03.rawValue)
            $0.leading.trailing.equalTo(glassView).inset(Space.base05.rawValue)
        }
        
        loginButton.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(Space.base05.rawValue)
            $0.leading.trailing.equalTo(glassView).inset(Space.base20.rawValue)
            $0.height.equalTo(40)
        }
        
        registerButton.snp.makeConstraints {
            $0.top.equalTo(loginButton.snp.bottom).offset(Space.base00.rawValue)
            $0.leading.trailing.equalTo(glassView).inset(Space.base04.rawValue)
        }
        
        googleButton.snp.makeConstraints {
            $0.top.equalTo(registerButton.snp.bottom).offset(Space.base04.rawValue)
            $0.leading.trailing.equalTo(glassView).inset(Space.base05.rawValue)
            $0.bottom.equalTo(glassView).offset(-Space.base03.rawValue)
            $0.height.equalTo(60)
        }
    }

    @objc private func signInGoogle() {
        interactor.googlePressed()
    }
    
    @objc private func registerPressed() {
        interactor.registerPressed()
    }
 
    @objc private func loginPressed() {
        interactor.validateLogin(email: emailTextField.getText(), password: passwordTextField.getText())
    }
}

extension LoginController: LoginDisplaying {
    func doSomething() {
    //
    }
}
