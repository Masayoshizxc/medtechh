//
//  ChecklistViewController.swift
//  MedTech
//
//  Created by Eldiiar on 3/6/22.
//

import UIKit

class ChecklistViewController: BaseViewController {
    
    var model = [Checklist]()
    
    let tableView: UITableView = {
        let table = UITableView()
        return table
    }()
    
    private lazy var sosButton4 : UIButton = {
        let button = UIButton()
        button.setTitle("SOS", for: .normal)
        button.tintColor = .black
        button.layer.cornerRadius = 18
        button.backgroundColor = UIColor(red: 255/255, green: 182/255, blue: 181/255, alpha: 1)
//        button.setTitleShadowColor(.black, for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 65, height: 44)
        //button.layer.shadowOffset = CGSize(width: 0, height: 4)
        //button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        //button.layer.shadowOpacity = 1.0
        //button.layer.shadowRadius = 16
        button.addTarget(self, action: #selector(didTapSosButton), for: .touchUpInside)
        
        return button
    }()
    //Fonts.SFProText.semibold.font(size: 20)
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Чеклист"
        let textAttributes = [NSAttributedString.Key.font: Fonts.SFProText.semibold.font(size: 20), NSAttributedString.Key.foregroundColor: UIColor(red: 92/255, green: 72/255, blue: 106/255, alpha: 1)]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        view.backgroundColor = .white
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: sosButton4)
        
        model.append(Checklist(first: "Первичный осмотр -", second: "28.09.2022"))
        model.append(Checklist(first: "Второй осмотр -", second: "04.11.2022"))
        model.append(Checklist(first: "Третий осмотр -", second: "28.09.2022"))
        model.append(Checklist(first: "Четвертый осмотр -", second: "04.11.2022"))
        model.append(Checklist(first: "Пятый осмотр -", second: "28.09.2022"))
        model.append(Checklist(first: "Шестой осмотр -", second: "04.11.2022"))
        model.append(Checklist(first: "Седьмой осмотр -", second: "28.09.2022"))
        model.append(Checklist(first: "Восьмой осмотр -", second: "04.11.2022"))
        model.append(Checklist(first: "Девятый осмотр -", second: "28.09.2022"))
        model.append(Checklist(first: "Десятый осмотр -", second: "04.11.2022"))
                        
        tableView.register(ChecklistTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = UIColor.clear
        tableView.backgroundColor = .white
        view.addSubview(tableView)
                
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    @objc func didTapSosButton() {
        print("SOS button tapped")
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
        
        //cell.textLabel?.text = model[indexPath.row].first
        
        let bottomBorder = CALayer()
        bottomBorder.frame = CGRect(x: 20.0, y: 63.0, width: cell.contentView.frame.size.width - 40, height: 1.0)
        bottomBorder.backgroundColor = UIColor(red: 0.627, green: 0.588, blue: 0.655, alpha: 1).cgColor
        cell.contentView.layer.addSublayer(bottomBorder)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = MoreChecklistViewController()
        vc.title = model[indexPath.row].first.replacingOccurrences(of: "-", with: "")
        navigationController?.pushViewController(vc, animated: true)
    }
        
}
