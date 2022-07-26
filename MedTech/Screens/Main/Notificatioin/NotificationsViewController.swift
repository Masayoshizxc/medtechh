//
//  NotificationsViewController.swift
//  MedTech
//
//  Created by Adilet on 17/6/22.
//

import UIKit
import SnapKit

class NotificationsViewController: UIViewController {
    var count = [1]
    var tableView = UITableView()
    let exitButton : UIButton = {
       let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = UIColor(red: 92/255, green: 72/255, blue: 106/255, alpha: 1)
        button.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        return button
    }()
    let titleForPage : UILabel = {
        let title = UILabel()
        title.text = "Уведомления"
        title.textColor = UIColor(red: 92/255, green: 72/255, blue: 106/255, alpha: 1)
//    background: rgba(92, 72, 106, 1);
        title.font = .boldSystemFont(ofSize: 29)
        return title
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUpSubviews()
        setUpTableView()
        setUpConstraints()
    }
    func setUpSubviews(){
        view.addSubviews(exitButton,
                         titleForPage,
                         tableView)
    }
    func setUpTableView(){
        tableView.delegate = self
        tableView.dataSource = self
//        tableView.backgroundColor = .yellow
        tableView.register(NotificationTableViewCell.self, forCellReuseIdentifier: NotificationTableViewCell.ID)
    }
    
    @objc func dismissView(){
        self.dismiss(animated: true, completion: nil)
    }
    
    func setUpConstraints(){
        exitButton.snp.makeConstraints{make in
            make.width.height.equalTo(40)
            make.top.equalToSuperview().inset(70)
            make.right.equalToSuperview().inset(30)
        }
        titleForPage.snp.makeConstraints{make in
            make.left.equalToSuperview().inset(27)
            make.top.equalToSuperview().inset(111)
        }
        tableView.snp.makeConstraints{make in
            make.top.equalTo(titleForPage.snp.bottom).offset(26)
            make.left.right.equalToSuperview().inset(27)
            make.bottom.equalToSuperview().inset(90)
        }
    }
    

}

extension NotificationsViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableView.rowHeight = 100
        return count.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NotificationTableViewCell.ID,for: indexPath)
//        cell.textLabel?.text = "Hello"
        return cell
        
    }
    
    
}

