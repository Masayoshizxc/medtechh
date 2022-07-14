//
//  CollectionView.swift
//  MedTech
//
//  Created by Adilet on 15/6/22.
//

import Foundation
import UIKit

class GalleryCollectionView: UICollectionView , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    
    var cells = [ForWeeks]()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(){
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        super.init(frame: .zero,collectionViewLayout: layout)
//        backgroundColor = UIColor(red: 239/255, green: 197/255, blue: 203/255, alpha: 1)
        delegate = self
        dataSource = self
        
        register(CollectionViewCell.self)
        
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func set(cells: [ForWeeks]){
        self.cells = cells
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cells.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = getReuseCell(CollectionViewCell.self, indexPath: indexPath)
        cell.fill(text: cells[indexPath.row].weeksNumbers)
        cell.mainImageView.layer.borderWidth = 1
        cell.mainImageView.layer.borderColor = UIColor(red: 92/255, green: 72/255, blue: 106/255, alpha: 1).cgColor
        cell.mainImageView.backgroundColor = .white
        return cell
        
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 50, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! CollectionViewCell
        cell.backgroundColor = .white
        if cell.isSelected {
            cell.mainImageView.layer.borderWidth = 2
            cell.mainImageView.layer.borderColor = UIColor(red: 1, green: 0.627, blue: 0.69, alpha: 1).cgColor
        } else {
            cell.mainImageView.layer.borderWidth = 0
            cell.mainImageView.layer.borderColor = UIColor(red: 0.973, green: 0.898, blue: 0.898, alpha: 1).cgColor
        }
        print(indexPath.row + 1)
        //cells[indexPath.row] = ForWeeks(weeksNumbers: String(indexPath.row + 1), isSelected: false)
        
    }
}

extension UICollectionView {
    
    func register<Cell: UICollectionViewCell>(_ cellType: Cell.Type) {
        register(cellType, forCellWithReuseIdentifier: cellType.identifier)
    }
    
    func getReuseCell<Cell: UICollectionViewCell>(
        _ cellType: Cell.Type,
        indexPath: IndexPath
    ) -> Cell {
        dequeueReusableCell(withReuseIdentifier: cellType.identifier, for: indexPath) as! Cell
    }
}
