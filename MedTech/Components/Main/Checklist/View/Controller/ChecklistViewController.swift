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
    var checklist = [ChecklistModel]()
    
    private let viewModel: ChecklistViewModelProtocol
    
    init(vm: ChecklistViewModelProtocol = ChecklistViewModel()) {
        viewModel = vm
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(ChecklistTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.separatorColor = UIColor.clear
        tableView.backgroundColor = .white
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
        let textAttributes = [NSAttributedString.Key.font: Fonts.SFProText.semibold.font(size: 20), NSAttributedString.Key.foregroundColor: UIColor(named: "Violet")]
        navigationController?.navigationBar.titleTextAttributes = textAttributes as [NSAttributedString.Key : Any]
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: sosButton4)
        
        getChecklists()
        
        tableView.delegate = self
        tableView.dataSource = self
                        
        view.addSubview(tableView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    func getChecklists() {
        let userId = userDefaults.getUserId()
        viewModel.getChecklists(id: userId) { result in
            self.checklist = result!
            let dateVisit = result![0].patientVisitDTO!.dateVisit
            self.model.append(Checklist(first: "Первичный осмотр -", second: dateVisit!))
            self.tableView.reloadData()
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
        vc.checklist = checklist[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
        
}
