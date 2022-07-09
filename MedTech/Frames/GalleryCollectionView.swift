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
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 50, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! CollectionViewCell
        if cell.isSelected {
            cell.mainImageView.layer.borderWidth = 5
            cell.mainImageView.layer.borderColor = UIColor.yellow.cgColor
        } else {
            cell.mainImageView.layer.borderWidth = 0
        }
        for cell in cells {
            var currentCell = cell
            currentCell.isSelected = true
        }
        cells[indexPath.row] = ForWeeks(weeksNumbers: String(indexPath.row + 1), isSelected: true)
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
