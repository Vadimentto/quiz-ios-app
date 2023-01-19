//
//  TitleVC.swift
//  tms-25-quiz
//
//  Created by Vadym Potapov on 06.12.2022.
//

import UIKit
import SnapKit
import Lottie

protocol CategoryCellProtocol: AnyObject {
    func categoryCellDidSelect(_ category: Category)
}

protocol StartButton: AnyObject {
    func startGameButtonCellDidSelect()
}

class TitleVC: UIViewController {
    
    weak var delegateStartButton: StartButton?
    
    weak var delegate: CategoryCellProtocol?
    
    var categories: [Category] = [] {
        didSet {
            collectionViewTitle.reloadData()
        }
    }
    
    
    
    var questionProvider = QuestionsProviderImpl.shared
    
    var currentCategory: Category?
    
    var zeroView = ZeroView.init(jsonName: "sleep-man")
    
    var data: [UIImageView] = [
        UIImageView(image: UIImage(named: "champions-league")),
        UIImageView(image: UIImage(named: "coatch-cat")),
        UIImageView(image: UIImage(named: "euro-cat")),
        UIImageView(image: UIImage(named: "players-cat")),
        UIImageView(image: UIImage(named: "premier-league-cat")),
        UIImageView(image: UIImage(named: "stadions-cat")),
        UIImageView(image: UIImage(named: "worldcup-cat"))
    ]
    
    var photos: [String] = ["champions-league", "coatch-cat", "euro-cat", "players-cat", "premier-league-cat", "stadions-cat", "worldcup-cat"]
    
    
    private lazy var collectionViewTitle: UICollectionView = {
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        //        let paddingSize = LayoutCV.paddingCount * LayoutCV.padding
        //        let cellSize = (UIScreen.width - paddingSize) / LayoutCV.itemsCount
        //
        
        layout.itemSize = CGSize(width: 190, height: 190)
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        //        layout.sectionInset = UIEdgeInsets(top: LayoutCV.padding, left: LayoutCV.padding, bottom: LayoutCV.padding, right: LayoutCV.padding)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(CategoryCollectionCell.self, forCellWithReuseIdentifier: CategoryCollectionCell.reuseId)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.layer.cornerRadius = 10
        collectionView.backgroundColor = UIColor(named: "background-color")
        collectionView.layer.borderWidth = 2
        collectionView.layer.borderColor = CGColor(red: 0.627, green: 0.663, blue: 0.988, alpha: 0.5)
        collectionView.layer.shadowColor = CGColor(red: 0.627, green: 0.663, blue: 0.988, alpha: 0.7)
        return collectionView
    }()
    
    private lazy var textTitleCategoty: UILabel = {
        
        let text = UILabel()
        text.text = "Select category"
        text.font = UIFont(name: "NotoSans-Bold", size: 20)
        text.textAlignment = .center
        text.textColor = .white
        
        return text
    }()
    
    private lazy var stackView: UIStackView = {
        
        let stack = UIStackView()
        stack.alignment = .center
        stack.spacing = 20
        stack.distribution = .equalCentering
        stack.backgroundColor = .none
        return stack
    }()
    
    private lazy var personButton: UIButton = {
        
        let view = UIButton(type: .custom)
        view.setImage(UIImage(systemName: "person.fill"), for: .normal)
        view.tintColor = UIColor(named: "light-blue")
        return view
    }()
    
    private lazy var settingButton: UIButton = {
        
        let view = UIButton(type: .custom)
        view.setImage(UIImage(systemName: "gearshape.fill"), for: .normal)
        view.tintColor = UIColor(named: "light-blue")
        return view
    }()
    
    private lazy var animationView: LottieAnimationView = {
        
        let scoreAnimation = LottieAnimationView()
        scoreAnimation.frame = CGRect(x: 0, y: 0, width: 70, height: 70)
        scoreAnimation.animation = .named("swipe")
        scoreAnimation.tintColor = UIColor(named: "light-blue")
        scoreAnimation.alpha = 0
        return scoreAnimation
    }()
    
    private lazy var startButton: UIButton = {
        
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 140, weight: .light, scale: .small)
               
        let largeBoldDoc = UIImage(systemName: "play.circle", withConfiguration: largeConfig)
        
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 0, y: 0, width: 70, height: 70)
        button.layer.cornerRadius = 0.5 * button.bounds.size.width
        button.clipsToBounds = true
        button.setImage(largeBoldDoc, for: .normal)
        button.tintColor = UIColor(named: "light-blue")
        button.backgroundColor = UIColor(named: "background-color")
        button.addTarget(self, action: #selector(startGameAction), for: .touchUpInside)
        button.alpha = 0
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        zeroView.show()
        setupViews()
        setupConstrains()
        
        questionProvider.fetchAllQuestions {
            
            self.categories = self.questionProvider.fetchAllCategories()
            self.questionProvider.shuffleQuestions()
            self.collectionViewTitle.reloadData()
            
            self.zeroView.hide()
            self.animationView.alpha = 1
            self.startButton.alpha = 1
            self.animationView.play()
            self.animationView.loopMode = .loop
        }
    }
    
    
    // MARK: - Private func
    
    private func setupViews() {
        
        view.addSubview(collectionViewTitle)
        navigationItem.hidesBackButton = true
        view.addSubview(zeroView)
        view.backgroundColor = UIColor(named: "background-color")
        view.addSubview(stackView)
        view.addSubview(textTitleCategoty)
        view.addSubview(personButton)
        view.addSubview(settingButton)
        view.addSubview(animationView)
        view.addSubview(startButton)
    }
    
    private func setupConstrains() {
        
        collectionViewTitle.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalToSuperview().inset(400)
            make.top.equalToSuperview().inset(120)
            make.left.right.equalToSuperview().inset(5)
            make.height.equalTo(200)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(40)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(70)
        }
        
        textTitleCategoty.snp.makeConstraints { make in
            make.top.left.right.bottom.equalTo(stackView)
        }
        
        personButton.snp.makeConstraints { make in
            make.top.bottom.equalTo(stackView)
            make.right.equalTo(textTitleCategoty).inset(50)
        }
        
        settingButton.snp.makeConstraints { make in
            make.top.bottom.equalTo(stackView)
            make.left.equalTo(personButton).inset(35)
        }
        
        animationView.snp.makeConstraints { make in
            make.top.equalTo(collectionViewTitle).inset(5)
            make.centerX.equalTo(collectionViewTitle.snp.centerX)
            make.height.equalTo(80)
            make.width.equalTo(80)
        }
        
        startButton.snp.makeConstraints { make in
            make.bottom.equalTo(collectionViewTitle).inset(-30)
            make.centerX.equalTo(collectionViewTitle.snp.centerX)
            make.height.equalTo(70)
            make.width.equalTo(70)
        }
        
        zeroView.pinEdgesToSuperView()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.zeroView.hide()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
            self.animationView.hide()
        }
    }
    
    // MARK: - Navigation
    
    func showStandardGameScreen() {
        let gameVC = ScreenFactoryImpl().makeStandardGameScreen()
        self.navigationController?.pushViewController(gameVC, animated: true)
    }
    
    
    func configure(_ categories: [Category]) {
        self.categories = categories
    }
    
    //MARK: - Public
    func configure(_ model: Category?) {
        
        if model != nil {
            startButton.isEnabled = true
        }
    }
    
    //MARK: - Actions
    @objc
    func startGameAction() {
        delegateStartButton?.startGameButtonCellDidSelect()
    }
    
}

extension TitleVC {
    struct LayoutCV {
        static let itemsCount: CGFloat = 20
        static let padding: CGFloat = 40
        static let paddingCount: CGFloat = itemsCount + 1
    }
}

extension TitleVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionCell.reuseId, for: indexPath) as? CategoryCollectionCell else { return UICollectionViewCell() }
        
        let photo = photos[indexPath.section]
        cell.configurePhoto(model: photo)
        let category = categories[indexPath.section]
        cell.configure(model: category)
        cell.delegate = self
        
        return cell
    }
    
}

extension TitleVC: UICollectionViewDelegate {
    
    
}


extension TitleVC: CategoryCollectionCellOutput {
    
    func categoryCollectionCellDidSelect(_ category: Category) {
        delegate?.categoryCellDidSelect(category)
    }
}

extension TitleVC: StartButton {
    
    func startGameButtonCellDidSelect() {
        showStandardGameScreen()
    }
}

extension TitleVC: CategoryCellOutput {
    
    func categoryCellDidSelect(_ category: Category) {
        
        currentCategory = category
        
        for item in categories {
            if item.name == category.name {
                item.selected = true
            } else {
                item.selected = false
            }
        }
        
        questionProvider.fetchQuestion(by: category) { [weak self] in
            self?.collectionViewTitle.reloadData()
        }
    }
    
    
}

