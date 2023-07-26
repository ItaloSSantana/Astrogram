import UIKit

class CustomButtonView: UIView {
    private lazy var image: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.layer.cornerRadius = 25
        return image
    }()
    
    private lazy var button: UIButton = {
        let btn = UIButton(type: .system)
        btn.clipsToBounds = true
        btn.layer.cornerRadius = 25
        btn.titleLabel?.font = .systemFont(ofSize: 22)
        btn.backgroundColor = .clear
        btn.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        return btn
    }()
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.textColor = .black
        return label
    }()
    
    var action: () -> Void = { /* Intentionally unimplemented */ }
    var isSelected: Bool = false
    
    init(title: String, image: String, radius: Float) {
        super.init(frame: .zero)
        self.label.text = title
        self.image.image = UIImage(named: image)
        self.button.layer.cornerRadius = CGFloat(radius)
        self.image.layer.cornerRadius = CGFloat(radius)
        buildHierarchy()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func buttonPressed() {
        action()
    }
    
    private func buildHierarchy() {
        addSubview(image)
        addSubview(label)
        addSubview(button)
        setupConstraints()
    }
       
    private func setupConstraints() {
        image.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(Space.base02.rawValue)
            $0.width.equalTo(45)
            $0.height.equalTo(45)
        }
        
        label.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(image.snp.trailing).offset(Space.base04.rawValue)
            $0.trailing.equalTo(self.snp.trailing).offset(-Space.base04.rawValue)
        }
        
        button.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    // MARK: - Enable Toggle Selection
//    func selectionView() {
//        guard isSelected else {
//            isSelected = true
//            backgroundImage.image = UIImage(named: Constants.selected)
//            return
//        }
//        isSelected = false
//        backgroundImage.image = UIImage(named: Constants.unselected)
//    }
    
    private func configureView() {
        clipsToBounds = true
        layer.cornerRadius = 25
        layer.shadowOffset = CGSize(width: 0.0, height: 0)
        layer.shadowOpacity = 0.4
        layer.shadowRadius = 10.0
        layer.masksToBounds = false
    }
}
