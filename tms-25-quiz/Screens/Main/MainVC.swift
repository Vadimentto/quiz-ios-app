//
//  MainVC.swift
//  tms-25-quiz
//
//  Created by Vadym Potapov on 28.10.2022.
//

import UIKit

enum CategorySectionType: Int, CaseIterable {
    case category //CategoryCell
    case startButton //StartGameButtonCell
}

class MainVC: UIViewController {
    
    var questionProvider = QuestionsProviderImpl.shared
    
    var categories: [Category] = []
    
    var currentCategory: Category?
    
    var zeroView = ZeroView.init(jsonName: "sleep-man")
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsSelection = false
        tableView.backgroundColor = UIColor(named: "background-color")
        tableView.separatorStyle = .none
        tableView.register(HeaderTableCell.self, forHeaderFooterViewReuseIdentifier: HeaderTableCell.reuseId)
        tableView.register(GameModeCell.self, forCellReuseIdentifier: GameModeCell.reuseId)
        tableView.register(CategoryCell.self, forCellReuseIdentifier: CategoryCell.reuseId)
        tableView.register(StartGameButtonCell.self, forCellReuseIdentifier: StartGameButtonCell.reuseId)
        return tableView
    }()
    
    private lazy var textTitleCategoty: UILabel = {
        
        let text = UILabel()
        text.text = "Select category"
        text.font = UIFont(name: "NotoSans-Bold", size: 20)
        text.textAlignment = .center
        text.textColor = .white
        text.alpha = 0
        
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
        view.alpha = 0
        return view
    }()
    
    private lazy var settingButton: UIButton = {
        
        let view = UIButton(type: .custom)
        view.setImage(UIImage(systemName: "gearshape.fill"), for: .normal)
        view.tintColor = UIColor(named: "light-blue")
        view.alpha = 0
        return view
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        zeroView.show()
        
        setupViews()
        setupConstraints()
        
        questionProvider.fetchAllQuestions {
            
            self.categories = self.questionProvider.fetchAllCategories()
            self.questionProvider.shuffleQuestions()
            self.tableView.reloadData()
            
            self.zeroView.hide()
            self.textTitleCategoty.alpha = 1
            self.personButton.alpha = 1
            self.settingButton.alpha = 1
        }
        
    }
    
    // MARK: - Private
    
    private func setupViews() {
        view.addSubview(tableView)
        navigationItem.hidesBackButton = true
        view.addSubview(zeroView)
    }
    
    private func setupConstraints() {
        tableView.snp.makeConstraints { make in
//            make.edges.equalTo(view.safeAreaLayoutGuide)
            make.edges.equalToSuperview()

        }
        
        zeroView.pinEdgesToSuperView()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.zeroView.hide()
        }
    }
    
    // MARK: - Navigation
    
    func showStandardGameScreen() {
        let gameVC = ScreenFactoryImpl().makeStandardGameScreen()
        self.navigationController?.pushViewController(gameVC, animated: true)
    }
}

extension MainVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return CategorySectionType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cellType = CategorySectionType.init(rawValue: indexPath.section) {
            
            switch cellType {
                
            case .category:
                
                guard let cell = tableView.dequeueReusableCell(withIdentifier: CategoryCell.reuseId, for: indexPath) as? CategoryCell else { return UITableViewCell() }
                
                cell.delegate = self
                cell.configure(categories)
                
                return cell
                
            case .startButton:
                
                guard let cell = tableView.dequeueReusableCell(withIdentifier: StartGameButtonCell.reuseId, for: indexPath) as? StartGameButtonCell else { return UITableViewCell() }
                
                cell.delegate = self
                cell.configure(currentCategory)
                
                return cell
                
            }
        }
        return UITableViewCell()
    }
}

extension MainVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: HeaderTableCell.reuseId)
        return header
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 60 : 0
    }
    
}

extension MainVC: StartGameButtonCellOutput {
    
    func startGameButtonCellDidSelect() {
        showStandardGameScreen()
    }
}

extension MainVC: CategoryCellOutput {
    
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
            self?.tableView.reloadData()
        }
    }
    
    
}
