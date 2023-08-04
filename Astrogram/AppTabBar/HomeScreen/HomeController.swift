import UIKit

protocol HomeDisplaying: AnyObject {
    func doSomething()
}

final class HomeController: ViewController<HomeInteracting, UIView> {
    private lazy var scrollView: UIScrollView = {
         let scroll = UIScrollView()
         scroll.backgroundColor = .clear
         return scroll
     }()
     
     private lazy var contentView: UIView = {
        let view = UIView()
         view.backgroundColor = .red
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
        return button
    }()
    
    private lazy var storiesCollection: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        collection.backgroundColor = .none
        collection.register(HomeStoriesCell.self, forCellWithReuseIdentifier: HomeStoriesCell.identifier)
        let layout = UICollectionViewFlowLayout()
        collection.collectionViewLayout = layout
        layout.scrollDirection = .horizontal
        collection.setCollectionViewLayout(layout, animated: true)
        collection.showsHorizontalScrollIndicator = true
        return collection
    }()
    
    private lazy var adjustView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        self.storiesCollection.delegate = self
        self.storiesCollection.dataSource = self
        self.storiesCollection.reloadData()
    }
    
    override func buildViewHierarchy() {
       // view.addSubview(scrollView)
       // scrollView.addSubview(contentView)
        view.addSubview(backgroundImage)
        view.addSubview(titleLabel)
        view.addSubview(searchButton)
        view.addSubview(storiesCollection)
        view.addSubview(adjustView)
    }
    
    override func setupConstraints() {
  
//        scrollView.snp.makeConstraints{
//            $0.edges.equalToSuperview()
//        }
//
//        contentView.snp.makeConstraints {
//            $0.leading.trailing.equalTo(scrollView.frameLayoutGuide)
//            $0.top.bottom.equalTo(scrollView.contentLayoutGuide)
//        }
        
        backgroundImage.snp.makeConstraints {
            $0.edges.equalTo(view)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.snp.top).offset(Space.base12.rawValue)
            $0.leading.equalTo(view.snp.leading).offset(Space.base06.rawValue)
        }
        
        searchButton.snp.makeConstraints {
            $0.top.equalTo(view.snp.top).offset(Space.base12.rawValue)
            $0.trailing.equalTo(view.snp.trailing).offset(-Space.base06.rawValue)
            $0.height.width.equalTo(46)
        }
        
        storiesCollection.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(Space.base01.rawValue)
            $0.leading.trailing.equalToSuperview()
            //$0.width.equalTo(UIScreen.main.bounds.width)
          //  $0.height.equalTo(70)
        }
        
//        adjustView.snp.makeConstraints {
//            $0.top.equalTo(storiesCollection.snp.bottom).offset(Space.base02.rawValue)
//            $0.leading.trailing.equalToSuperview()
//            $0.bottom.equalToSuperview().offset(-Space.base02.rawValue)
//        }
    }
}

extension HomeController: HomeDisplaying {
    func doSomething() {
        //
    }
}

extension HomeController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeStoriesCell.identifier, for: indexPath) as? HomeStoriesCell else {return UICollectionViewCell()}
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: 222, height: 222)
//    }
    
}
