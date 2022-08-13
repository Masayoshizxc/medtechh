//
//  NotificationsViewController.swift
//  MedTech
//
//  Created by Adilet on 17/6/22.
//

import UIKit
import SnapKit

class NotificationsViewController: BaseViewController {

    var model = [Notifications]()
    var tableView = UITableView()

    private lazy var exitButton : UIButton = {
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
        title.font = .boldSystemFont(ofSize: 29)
        return title
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpSubviews()
        setUpTableView()
        setUpConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UserDefaultsService.shared.saveNotificationCount(count: model.count)
    }
    func setUpSubviews(){
        view.addSubviews(exitButton,
                         titleForPage,
                         tableView)
    }
    func setUpTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(NotificationTableViewCell.self, forCellReuseIdentifier: NotificationTableViewCell.ID)
    }
    
    @objc func dismissView(){
        self.dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func setUpConstraints(){
        exitButton.snp.makeConstraints{make in
            make.width.height.equalTo(40)
            make.top.equalToSuperview().inset(40)
            make.right.equalToSuperview().inset(30)
        }
        titleForPage.snp.makeConstraints{make in
            make.left.equalToSuperview().inset(27)
            make.top.equalToSuperview().inset(75)
        }
        tableView.snp.makeConstraints{make in
            make.top.equalTo(titleForPage.snp.bottom).offset(26)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    

}

extension NotificationsViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableView.rowHeight = 100
        return model.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NotificationTableViewCell.ID,for: indexPath) as! NotificationTableViewCell
        cell.clipsToBounds = true
        cell.layer.cornerRadius = 5
        cell.getData(model: model[indexPath.row])
        return cell
        
    }
    
    
}

