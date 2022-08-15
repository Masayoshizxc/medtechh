//
//  DrugsTableViewCell.swift
//  MedTech
//
//  Created by Adilet on 15/8/22.
//

import UIKit

class DrugTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "DrugTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
