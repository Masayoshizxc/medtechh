//
//  MoreChecklistViewController.swift
//  MedTech
//
//  Created by Eldiiar on 8/7/22.
//

import UIKit

class MoreChecklistViewController: BaseViewController {
    
    var model = [Checklists]()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(ChecklistCollectionViewCell.self)
        return cv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(40)
        }
        
        model.append(Checklists(image: Icons.file.image, title: "Обследование"))
        model.append(Checklists(image: Icons.beakers.image, title: "Назначения лабораторных исследований"))
        model.append(Checklists(image: Icons.childObserve.image, title: "Обследование плода"))
        model.append(Checklists(image: Icons.domino.image, title: "Профилактические мероприятия"))
        model.append(Checklists(image: Icons.checkmark.image, title: "Дополнительные назначения"))
        model.append(Checklists(image: Icons.warning.image, title: "Заключение"))
    }
    

}

extension MoreChecklistViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.getReuseCell(ChecklistCollectionViewCell.self, indexPath: indexPath)
        cell.backgroundColor = UIColor(red: 0.973, green: 0.898, blue: 0.898, alpha: 1)
        cell.layer.cornerRadius = 20
        cell.getData(model: model[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(model[indexPath.row].title, "selected")
        let vc = MoreMoreChecklistViewController()
        vc.title = model[indexPath.row].title
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 160, height: 200)
    }
        
}
