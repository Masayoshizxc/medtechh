//
//  ChecklistViewController.swift
//  MedTech
//
//  Created by Eldiiar on 3/6/22.
//

import UIKit

class ChecklistViewController: BaseViewController {
    
    let userDefaults = UserDefaultsService()
    var model = [Checklist]()
    var appointments = ["Первичный осмотр -", "Второй осмотр -", "Третий осмотр -", "Четвертый осмотр -", "Пятый осмотр -",
                        "Шестой осмотр -", "Седьмой осмотр -", "Восьмой осмотр -", "Девятый осмотр -", "Десятый осмотр -"]
    
    private let viewModel: ChecklistViewModelProtocol
    
    init(vm: ChecklistViewModelProtocol = ChecklistViewModel()) {
        viewModel = vm
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(ChecklistTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.separatorColor = UIColor.clear
        tableView.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    private lazy var sosButton4 : UIButton = {
        let button = UIButton()
        button.setTitle("SOS", for: .normal)
        button.tintColor = .black
        button.layer.cornerRadius = 18
        button.backgroundColor = UIColor(named: "Peach")
        button.frame = CGRect(x: 0, y: 0, width: 65, height: 44)
        button.addTarget(self, action: #selector(didTapSosButton), for: .touchUpInside)
        
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Чеклист"
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: sosButton4)
        
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(didPullRefresh), for: .valueChanged)
        
        getChecklists()
                        
        view.addSubview(tableView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    @objc func didPullRefresh() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.getChecklists()
            self.tableView.reloadData()
            self.tableView.refreshControl?.endRefreshing()
        }
    }
    
    func getChecklists() {
        viewModel.getChecklists { result in
            if result == .success {
                for i in 0..<self.viewModel.model.count {
                    let dateVisit = self.viewModel.model[i].patientVisitDTO!.dateVisit
                    self.model.append(Checklist(first: self.appointments[i], second: dateVisit!))
                }
                self.tableView.reloadData()
            } else {
                print("Error")
            }
        }
    }
    
    @objc func didTapSosButton() {
        let number = userDefaults.getEmergency()
        callNumber(phoneNumber: number)
    }
    
    private func callNumber(phoneNumber:String) {
      if let phoneCallURL = URL(string: "tel://\(phoneNumber)") {
        let application:UIApplication = UIApplication.shared
        if (application.canOpenURL(phoneCallURL)) {
            application.open(phoneCallURL, options: [:], completionHandler: nil)
        }
      }
    }

}

extension ChecklistViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ChecklistTableViewCell
        cell.backgroundColor = .white
        
        cell.setUpData(model: model[indexPath.row])
                
        let bottomBorder = CALayer()
        bottomBorder.frame = CGRect(x: 20.0, y: 63.0, width: cell.contentView.frame.size.width - 40, height: 1.0)
        bottomBorder.backgroundColor = UIColor(named: "LightViolet")?.cgColor
        cell.contentView.layer.addSublayer(bottomBorder)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = CategoriesViewController()
        vc.title = model[indexPath.row].first.replacingOccurrences(of: "-", with: "")
        vc.checklist = viewModel.model[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
        
}
