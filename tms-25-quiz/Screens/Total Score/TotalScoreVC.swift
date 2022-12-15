//
//  TotalScoreVC.swift
//  tms-25-quiz
//
//  Created by Vadym Potapov on 29.11.2022.
//

import UIKit

class TotalScoreVC: UIViewController {
    
    lazy var tableView: UITableView = {
        
        var table = UITableView()
        table.delegate = self
        table.dataSource = self
        table.register(TotalScoreCell.self, forCellReuseIdentifier: TotalScoreCell.reuseId)
        table.accessibilityViewIsModal = true
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstrains()
       
    }
    
    func setupViews() {
        
        view.addSubview(tableView)
    }
    
    func setupConstrains() {
        
        tableView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
    }

}

extension TotalScoreVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       guard let cell = tableView.dequeueReusableCell(withIdentifier: TotalScoreCell.reuseId, for: indexPath) as? TotalScoreCell else { return UITableViewCell() }
        return cell
    }

    
}

extension TotalScoreVC: UITableViewDelegate {
    
    
}

