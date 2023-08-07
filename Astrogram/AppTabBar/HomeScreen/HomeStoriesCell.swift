import UIKit

class HomeStoriesCell: UICollectionViewCell {
    static let identifier = "HomeStoriesCell"
    
    private lazy var blankView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private lazy var  image: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: Constants.Images.defaultUser)
        image.clipsToBounds = true
        image.layer.cornerRadius = 45
        image.layer.borderWidth = 3
        image.layer.borderColor = UIColor(hexaRGBA: Constants.Colors.whiteColor)?.cgColor
        image.contentMode = .scaleAspectFill
        return image
    }()
 
    private lazy var label: UILabel = {
       let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 14)
        label.textAlignment = .center
        label.text = "Amigoamigo"
        return label
    }()
    
    override init(frame: CGRect) {
           super.init(frame: .zero)
           buildHierarchy()
       }
       
       required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
    
    private func buildHierarchy() {
        self.addSubview(blankView)
        blankView.addSubview(image)
        blankView.addSubview(label)
        setupConstraints()
    }
    
    private func setupConstraints() {
        blankView.snp.makeConstraints {
            $0.top.equalToSuperview()
           // $0.bottom.equalToSuperview()
            //$0.trailing.equalToSuperview()
            $0.leading.equalToSuperview().offset(Space.base02.rawValue)
            $0.height.equalTo(110)
            $0.width.equalTo(110)
        }
        
        image.snp.makeConstraints {
            $0.top.equalTo(blankView.snp.top)
            $0.centerX.equalTo(blankView.snp.centerX)
            $0.height.width.equalTo(90)
        }

        label.snp.makeConstraints {
            $0.top.equalTo(image.snp.bottom).offset(Space.none.rawValue)
            $0.centerX.equalTo(blankView.snp.centerX)
            $0.width.equalTo(image.snp.width)
            $0.bottom.equalTo(blankView.snp.bottom)
        }
    }
}
