import UIKit

class ProfilePostsCell: UICollectionViewCell {
    static let identifier = "ProfilePostsCell"
    
    private lazy var postImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: Constants.Images.defaultUser)
        image.clipsToBounds = true
        image.layer.cornerRadius = 15
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    override init(frame: CGRect) {
           super.init(frame: .zero)
           buildHierarchy()
       }
       
       required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
    
    private func buildHierarchy() {
        addSubview(postImage)
        setupConstraints()
    }
    
    private func setupConstraints() {
        postImage.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.height.equalTo(100)
            $0.width.equalTo(100)
        }
    }
}
