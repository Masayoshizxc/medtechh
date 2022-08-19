//
//  MoreChecklistViewController.swift
//  MedTech
//
//  Created by Eldiiar on 8/7/22.
//

import UIKit

class CategoriesViewController: BaseViewController {
    
    var model = [Checklists]()
    var checklist: ChecklistModel?
    
    private lazy var collectionView: UICollectionView = {
        let screenWidth = view.frame.size.width - 64
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 8
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: screenWidth/2, height: 200)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(ChecklistCollectionViewCell.self)
        return cv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(27)
            make.left.right.equalToSuperview().inset(27)
            make.bottom.equalToSuperview()
        }
        
        model.append(Checklists(image: Icons.file.image, title: "Обследование"))
        model.append(Checklists(image: Icons.beakers.image, title: "Назначения лабораторных исследований"))
        model.append(Checklists(image: Icons.domino.image, title: "Профилактические мероприятия"))
        model.append(Checklists(image: Icons.checkmark.image, title: "Дополнительные назначения"))
        model.append(Checklists(image: Icons.warning.image, title: "Заключение"))
    }
    

}

extension CategoriesViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
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
        switch indexPath.row {
        case 0:
            let vc = QuestionAnswerViewController()
            vc.title = model[indexPath.row].title
            vc.checklist = checklist
            navigationController?.pushViewController(vc, animated: true)
        case 1:
            let vc = AnalysesViewController()
            vc.title = model[indexPath.row].title
            vc.checklist = checklist
            navigationController?.pushViewController(vc, animated: true)
        case 2:
            let vc = DrugViewController()
            vc.title = model[indexPath.row].title
            vc.checklist = checklist
            navigationController?.pushViewController(vc, animated: true)
        case 3:
            let vc = ExtraInfoViewController()
            vc.title = model[indexPath.row].title
            vc.checklist = checklist
            navigationController?.pushViewController(vc, animated: true)
        case 4:
            let vc = ConclusionViewController()
            vc.title = model[indexPath.row].title
            vc.checklist = checklist
            navigationController?.pushViewController(vc, animated: true)
        default:
            break
        }
    }
    
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: widthComputed(160), height: 200)
//    }
        
}
