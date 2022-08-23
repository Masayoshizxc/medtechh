//
//  NotificationsViewController.swift
//  MedTech
//
//  Created by Adilet on 17/6/22.
//

import UIKit
import SnapKit

class NotificationsViewController: BaseViewController {

    private var viewModel: HomeViewModelProtocol

    init(vm: HomeViewModelProtocol = HomeViewModel()) {
        viewModel = vm
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var model = [Notifications]()
    var tableView = UITableView()

    private lazy var exitButton : UIButton = {
       let button = UIButton()
        button.setImage(Icons.downArrow.image, for: .normal)
        button.tintColor = UIColor(red: 92/255, green: 72/255, blue: 106/255, alpha: 1)
        button.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        return button
    }()
    let titleForPage : UILabel = {
        let title = UILabel()
        title.text = "Уведомления"
        title.textColor = UIColor(named: "Violet")
        title.font = .boldSystemFont(ofSize: 29)
        return title
    }()
    
    private lazy var deleteAllButton: UIButton = {
        let button = UIButton()
        button.setTitle("Стереть все", for: .normal)
        button.addTarget(self, action: #selector(didTapDeleteAll), for: .touchUpInside)
        button.setTitleColor(UIColor(named: "Violet"), for: .normal)
        button.titleLabel?.font = Fonts.SFProText.semibold.font(size: 14)
        return button
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
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: true)
        tableView.setEditing(editing, animated: true)
    }
    
    func setUpSubviews(){
        view.addSubviews(exitButton,
                         titleForPage,
                         deleteAllButton,
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
    
    @objc func didTapDeleteAll() {
        guard model.count > 0 else {
            return
        }
        let sheet = UIAlertController(title: "Стереть все", message: "Вы хотите стереть все?", preferredStyle: .alert)
        sheet.addAction(UIAlertAction(title: "Отменить", style: .destructive, handler: { _ in
            self.dismiss(animated: true)
        }))
        sheet.addAction(UIAlertAction(title: "Да", style: .default, handler: { _ in
            self.viewModel.deleteAllNotifications()
            self.viewModel.getNotifications { result in
                print(result)
                switch result {
                case .success:
                    self.model = self.viewModel.notifications!
                    self.tableView.reloadData()
                case .failure:
                    print("There was an error with getting notifications")
                }
            }
            
        }))
        present(sheet, animated: true)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func setUpConstraints(){
        exitButton.snp.makeConstraints{make in
            make.width.height.equalTo(40)
            make.top.equalToSuperview().inset(10)
            make.centerX.equalToSuperview()
        }
        titleForPage.snp.makeConstraints{make in
            make.left.equalToSuperview().inset(27)
            make.top.equalToSuperview().inset(75)
        }
        
        deleteAllButton.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(10)
            make.bottom.equalTo(tableView.snp.top)
            make.height.equalTo(30)
            make.width.equalTo(90)
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
        tableView.rowHeight = 140
        return model.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NotificationTableViewCell.ID,for: indexPath) as! NotificationTableViewCell
        cell.clipsToBounds = true
        cell.layer.cornerRadius = 5
        cell.getData(model: model[indexPath.row])
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete{
            guard let id = model[indexPath.row].id else {
                return
            }
            model.remove(at: indexPath.row)
            viewModel.deleteNotificationsById(id: id)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        }
    }
    
}

