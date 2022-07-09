//
//  ChecklistViewController.swift
//  MedTech
//
//  Created by Eldiiar on 3/6/22.
//

import UIKit

class ChecklistViewController: UIViewController {
    
    let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Чеклист"
        view.backgroundColor = .white
        
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }

}

extension ChecklistViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "Первичный осмотр - 28.09.2022"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = MoreChecklistViewController()
        vc.title = "Первичный осмотр - 28.09.2022"
        navigationController?.pushViewController(vc, animated: true)
    }
        
}
