//
//  MoreMoreChecklistViewController.swift
//  MedTech
//
//  Created by Eldiiar on 31/7/22.
//

import UIKit
import SnapKit

class DrugViewController: BaseViewController {
    private lazy var doctorImage : UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "doctor")
        img.layer.cornerRadius = img.frame.size.width/2
        
        return img
    }()
    private lazy var doctorName : UILabel = {
        let l = UILabel()
        l.numberOfLines = 0
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = .boldSystemFont(ofSize: 16)
        l.text = "Хафизова Валентина Владимировна"
        l.textColor = UIColor(named: "Violet")
        return l
    }()
    private lazy var doctorPos : UILabel = {
        let l = UILabel()
        l.numberOfLines = 0
        l.translatesAutoresizingMaskIntoConstraints = false
        l.text = "Гинеколог"
        l.textColor = UIColor(named: "LightViolet")
        l.font = .systemFont(ofSize: 14)
        return l
    }()
    private lazy var titleFor : UILabel = {
        let l = UILabel()
        l.numberOfLines = 0
        l.text = "Особенности организма пациентки"
        l.font = .boldSystemFont(ofSize: 19)
        l.textColor = UIColor(named: "Violet")
        return l
    }()
    private lazy var textAboutPatient : UILabel = {
        let l = UILabel()
        l.numberOfLines = 0
        l.text = "Resäsamma astrogisk.Vir or safelogi. Kompetensväxling lyr anteledes, rens respektive ding. Pretähur vanade sedan åsiktskorridor och bemise mide. Astrona polynår. Trafävis osade, eftersom poskap att oktig."
        l.textColor = UIColor(named: "Violet")
        l.font = .systemFont(ofSize: 14)
        
        return l
    }()
    private lazy var titleFor1 : UILabel = {
        let l = UILabel()
        l.numberOfLines = 0
        l.text = "Медикаменты"
        l.textColor = UIColor(named: "Violet")
        l.font = .systemFont(ofSize: 16)
        
        return l
    }()
    private lazy var tableView : UITableView = {
        let t = UITableView()
        t.register(DrugTableViewCell.self, forCellReuseIdentifier: DrugTableViewCell.reuseIdentifier)
        t.delegate = self
        t.dataSource = self
        t.backgroundColor = .purple
        return t
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSubviews()
        setUpConstraints()
        
    }
    
    func setUpSubviews(){
        view.addSubviews(doctorImage,
                         doctorName,
                         doctorPos,
                         titleFor,
                         textAboutPatient,
                         titleFor1,
                         tableView)
    }
    
    func setUpConstraints(){
        doctorImage.snp.makeConstraints{make in
            make.top.equalToSuperview().inset(113)
            make.left.equalToSuperview().inset(27)
            make.width.height.equalTo(60)
        }
        doctorName.snp.makeConstraints{make in
            make.top.equalToSuperview().inset(115)
            make.left.equalTo(doctorImage.snp.right).offset(18)
            make.right.equalToSuperview().inset(27)
            make.height.equalTo(38)
        }
        doctorPos.snp.makeConstraints{make in
            make.top.equalTo(doctorName.snp.bottom)
            make.left.equalTo(doctorImage.snp.right).offset(18)
            make.height.equalTo(18)
        }
        titleFor.snp.makeConstraints{make in
            make.top.equalTo(doctorImage.snp.bottom).offset(29)
            make.left.equalToSuperview().inset(27)
            
        }
        textAboutPatient.snp.makeConstraints{make in
            make.top.equalTo(titleFor.snp.bottom).offset(14)
            make.left.right.equalToSuperview().inset(27)
            
        }
        titleFor1.snp.makeConstraints{make in
            make.top.equalTo(textAboutPatient.snp.bottom).offset(14)
            make.left.right.equalToSuperview().inset(27)
            
        }
        tableView.snp.makeConstraints{make in
            make.top.equalTo(titleFor1.snp.bottom).offset(14)
            make.left.right.equalToSuperview().inset(27)
        }
    }
}

extension DrugViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DrugTableViewCell.reuseIdentifier, for: indexPath)
        cell.backgroundColor = .systemPink
        cell.textLabel?.text = "Hello Kitty"
        return cell
    }
    
    
}
