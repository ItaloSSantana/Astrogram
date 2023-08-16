import UIKit

class SearchCell: UITableViewCell {
    static let identifier = "SearchCell"
    
    private lazy var userImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: Constants.Images.defaultUser)
        image.clipsToBounds = true
        image.layer.cornerRadius = 30
        image.layer.borderWidth = 3
        image.layer.borderColor = UIColor(hexaRGBA: Constants.Colors.whiteColor)?.cgColor
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private lazy var nameLabel: UILabel = {
       let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 15)
        label.textAlignment = .left
        label.text = "Amigoamigo"
        return label
    }()
    
    private lazy var nickLabel: UILabel = {
       let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 13)
        label.textAlignment = .left
        label.text = "@Amigoamigo"
        return label
    }()
    
    private lazy var verticalStack: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 2
        stack.distribution = .equalSpacing
        stack.alignment = .fill
        stack.axis = .vertical
        stack.backgroundColor = .clear
        return stack
    }()
   
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        buildHierarchy()
    }
      
      required init?(coder: NSCoder) {
          fatalError("init(coder:) has not been implemented")
      }
    
    private func buildHierarchy() {
        addSubview(userImage)
        addSubview(verticalStack)
        verticalStack.addArrangedSubview(nameLabel)
        verticalStack.addArrangedSubview(nickLabel)
        setupConstraints()
    }
    
    private func setupConstraints() {
        userImage.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Space.base03.rawValue)
            $0.leading.equalToSuperview().offset(Space.base07.rawValue)
            $0.height.equalTo(60)
            $0.width.equalTo(60)
        }
 
        verticalStack.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Space.base06.rawValue)
            $0.leading.equalTo(userImage.snp.trailing).offset(Space.base03.rawValue)
            $0.trailing.equalToSuperview().offset(Space.base03.rawValue)
            $0.bottom.equalToSuperview().offset(-Space.base07.rawValue)
        }
    }
    
    func setupCell(user: UserDataViewModel) {
        userImage.kf.setImage(with: URL(string: user.image))
        nameLabel.text = user.name
        nickLabel.text = "@\(user.nick)"
    }
}
