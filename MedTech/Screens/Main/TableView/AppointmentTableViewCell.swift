//
//  AppointmentTableViewCell.swift
//  MedTech
//
//  Created by Adilet on 10/7/22.
//

import UIKit

class AppointmentTableViewCell: UITableViewCell {
    let doctorView : UIView = {
        let view = UIView()
        view.backgroundColor = .systemOrange
        return view
    }()
    
//    let section = TableViewCell
    override func awakeFromNib() {
        super.awakeFromNib()
        self.doctorView.layer.borderColor = UIColor.yellow.cgColor
        doctorView.layer.borderWidth = 5
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        doctorView.backgroundColor = .red
    }

    
    
}
