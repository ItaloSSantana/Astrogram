import UIKit

protocol HomeDisplaying: AnyObject {
    func displayPosts(posts: [PostViewModel])
    func loadCurrentUserData(user: UserDataViewModel)
}

final class HomeController: ViewController<HomeInteracting, UIView> {
    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.backgroundColor = .clear
        scroll.showsVerticalScrollIndicator = false
        return scroll
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private lazy var backgroundImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: Constants.Images.settingsBackground)
        return image
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "AstroGram"
        label.numberOfLines = 1
        label.textColor = .white
        label.font = .systemFont(ofSize: 26)
        label.textAlignment = .center
        label.layer.shadowColor = UIColor(hexaRGBA: Constants.Colors.whiteColor)?.cgColor
        label.layer.shadowOffset = CGSize(width: 0, height: 0)
        label.layer.shadowOpacity = 1.0
        label.layer.shadowRadius = 14.0
        label.layer.masksToBounds = false
        return label
    }()
    
    private lazy var searchButton: CDefaultButton = {
        let button = CDefaultButton(image: Constants.Images.searchIcon,
                                    radius: 23,
                                    color: Constants.Colors.darkColor,
                                    shadow: Constants.Colors.darkColor)
        button.action = {
            self.searchPressed()
        }
        return button
    }()
    
    private lazy var storiesCollection: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: 80, height: 80)
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        let collectionview = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionview.showsHorizontalScrollIndicator = false
        collectionview.dataSource = self
        collectionview.delegate = self
        collectionview.register(HomeStoriesCell.self, forCellWithReuseIdentifier: HomeStoriesCell.identifier)
        collectionview.showsVerticalScrollIndicator = false
        collectionview.backgroundColor = .clear
        return collectionview
    }()
     
    private lazy var verticalStack: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 13
        stack.distribution = .equalSpacing
        stack.alignment = .fill
        stack.axis = .vertical
        stack.backgroundColor = .clear
        return stack
    }()
        
    private var postList: [PostViewModel] = []
    var currentUser: UserDataViewModel?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        interactor.loadCurrentUserData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.storiesCollection.reloadData()
        interactor.loadData()
    }
    
    override func buildViewHierarchy() {
        view.addSubview(backgroundImage)
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(searchButton)
        contentView.addSubview(storiesCollection)
        contentView.addSubview(verticalStack)
    }
    
    override func setupConstraints() {
        
        scrollView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.height.greaterThanOrEqualTo(view.safeAreaLayoutGuide.snp.height)
            $0.edges.width.equalToSuperview()
        }
        
        backgroundImage.snp.makeConstraints {
            $0.edges.equalTo(view)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(contentView.snp.top).offset(Space.base02.rawValue)
            $0.leading.equalTo(contentView.snp.leading).offset(Space.base06.rawValue)
        }
        
        searchButton.snp.makeConstraints {
            $0.top.equalTo(contentView.snp.top).offset(Space.base02.rawValue)
            $0.trailing.equalTo(contentView.snp.trailing).offset(-Space.base06.rawValue)
            $0.height.width.equalTo(46)
        }
        
        storiesCollection.snp.makeConstraints {
            $0.top.equalTo(searchButton.snp.bottom).offset(Space.base01.rawValue)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(100)
        }
        
        verticalStack.snp.makeConstraints {
            $0.top.equalTo(storiesCollection.snp.bottom).offset(Space.base02.rawValue)
            $0.leading.trailing.equalToSuperview().inset(Space.base03.rawValue)
            $0.bottom.equalToSuperview().offset(-Space.base02.rawValue)
        }
    }
    
    @objc private func searchPressed() {
        interactor.searchPressed()
    }
}

extension HomeController: HomeDisplaying {
    func displayPosts(posts: [PostViewModel]) {
        posts.forEach { (post) in
            let postCard = CustomPostView()
            postCard.setupView(post: post)
            verticalStack.addArrangedSubview(postCard)
        }
    }
    
    func loadCurrentUserData(user: UserDataViewModel) {
        currentUser = user
    }
}

extension HomeController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeStoriesCell.identifier, for: indexPath) as? HomeStoriesCell else { return UICollectionViewCell() }
        return cell
    }
}
