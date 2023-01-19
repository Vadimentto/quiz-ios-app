//
//  PersonalScoreVC.swift
//  tms-25-quiz
//
//  Created by Vadym Potapov on 25.11.2022.
//

import UIKit

class PersonalScoreVC: UIViewController {
    
    lazy var totalScoreHeader = ScoreHeaderView()
    
    var scoreArchiver = ScoreArchiverImpl()

    var scoreModel: Score?
    
    var scores: [Score] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    lazy var homeBarButton: UIBarButtonItem = {
        let image = UIImage(systemName: "house.fill")
        let button = UIBarButtonItem.init(image: image, style: .plain, target: self, action: #selector(homeBarButtonAction))
        button.tintColor = UIColor(named: "light-blue")
//        button.setBackgroundImage(UIImage(named: "ted-lasso") ,for : UIControl.State.normal, barMetrics: UIBarMetrics.default)
        return button
    }()
    
    lazy var totalScoreButtun: UIBarButtonItem = {
        
       let image = UIImage(systemName: "star.circle.fill")
        let button = UIBarButtonItem.init(image: image, style: .plain, target: self, action: #selector(totalScoreButtonAction))
        button.tintColor = UIColor(named: "light-blue")
        return button
    }()
    
    lazy var tableView: UITableView = {
        
        var table = UITableView()
        table.delegate = self
        table.dataSource = self
        table.register(ScoreCell.self, forCellReuseIdentifier: ScoreCell.reuseId)
        table.backgroundColor = UIColor(named: "background-color")
        return table
    }()
    
    init(model: Score) {
        super.init(nibName: nil, bundle: nil)
        
        scoreModel = model
        scores = scoreArchiver.retrieve()
        scores.insert(model, at: 0)
        scoreArchiver.save(scores)
        totalScoreHeader.configure(totalScore: model.correctQuestionIds.count)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstrains()
    }
    
    
    func setupViews() {
        view.backgroundColor = .black
        view.addSubview(tableView)
        navigationItem.rightBarButtonItem = homeBarButton
        navigationItem.leftBarButtonItem = totalScoreButtun
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.barTintColor = UIColor(named: "background-color")
        navigationController?.navigationBar.backgroundColor = UIColor(named: "background-color")
        navigationItem.hidesBackButton = true
        
    }
    
    func setupConstrains() {
        
        tableView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
    }
    
    // MARK: - Actions
    
    @objc
    func homeBarButtonAction() {
        let mainVC = ScreenFactoryImpl().makeMainScreen()
        navigationController?.pushViewController(mainVC, animated: true)
    }
    
    @objc func totalScoreButtonAction () {
        let totalVC = ScreenFactoryImpl().makeTotalScreen()
        navigationController?.pushViewController(totalVC, animated: true)
    }
    
}

extension PersonalScoreVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scores.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       guard let cell = tableView.dequeueReusableCell(withIdentifier: ScoreCell.reuseId, for: indexPath) as? ScoreCell else { return UITableViewCell() }
        
        let score = scores[indexPath.row]
        cell.configure(score)
        return cell
    }

    
}

extension PersonalScoreVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return totalScoreHeader
    }
}
