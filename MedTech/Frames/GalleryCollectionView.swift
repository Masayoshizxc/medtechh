//
//  CollectionView.swift
//  MedTech
//
//  Created by Adilet on 15/6/22.
//

import Foundation
import UIKit

class GalleryCollectionView: UICollectionView , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
class A: UIView {
    private let colle: UICollectionView = {
        .init(frame: .zero)
    }()
    
}

//extension A: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
//
//}
//class GalleryCollectionView: UICollectionView {
    
    
        
    var cells = [ForWeeks]()
    
//    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
//        super.init(frame: frame, collectionViewLayout: collectionViewLayout)
//
//    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    let del = Delegate()
    
    init(){
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        super.init(frame: .zero,collectionViewLayout: layout)
        backgroundColor = UIColor(red: 239/255, green: 197/255, blue: 203/255, alpha: 1)
        delegate = self
        dataSource = self
//        self = self
        register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.identifier)
        
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
        let cell = dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier, for: indexPath) as! CollectionViewCell
        let c = getReuseCell(CollectionViewCell.self, indexPath: indexPath)
//        cell.numbersOfWeeks.text = cells[indexPath.row].weeksNumbers
        cell.fill(text: cells[indexPath.row].weeksNumbers)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! CollectionViewCell
        cell.mainImageView.layer.borderWidth = 5
        cell.mainImageView.layer.borderColor = UIColor.yellow.cgColor
        cell.mainImageView.backgroundColor = .none
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 50, height: 50)
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

class Delegate: NSObject, UICollectionViewDelegateFlowLayout {
    
}
