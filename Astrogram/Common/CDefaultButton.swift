import UIKit

class CDefaultButton: UIView {
    private lazy var image: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
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
    
    var action: () -> Void = { /* Intentionally unimplemented */ }
    var isSelected: Bool = false
    
    init(image: String, radius: Float, color: String, shadow: String) {
        super.init(frame: .zero)
        self.image.image = UIImage(named: image)
        self.button.layer.cornerRadius = CGFloat(radius)
        self.layer.cornerRadius = CGFloat(radius)
        self.layer.shadowColor = UIColor(hexaRGBA: shadow)?.cgColor
        self.backgroundColor = UIColor(hexaRGBA: color)
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
        addSubview(button)
        setupConstraints()
    }
       
    private func setupConstraints() {
        image.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
       
        button.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    private func configureView() {
        clipsToBounds = true
        layer.shadowOffset = CGSize(width: 0.0, height: 0)
        layer.shadowOpacity = 0.4
        layer.shadowRadius = 10.0
        layer.masksToBounds = false
    }
    
    func setImage(image: String) {
        self.image.image = UIImage(named: image)
    }
}
