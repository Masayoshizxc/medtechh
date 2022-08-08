//
//  MoreMoreChecklistViewController.swift
//  MedTech
//
//  Created by Eldiiar on 31/7/22.
//

import UIKit

class QuestionAnswerViewController: BaseViewController {
        
    var id: Int?
    private let viewModel: ChecklistViewModelProtocol
    
    init(vm: ChecklistViewModelProtocol = ChecklistViewModel()) {
        viewModel = vm
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getAnswers(id: 2, completion: { result in
            switch result {
            case .success:
                print(self.viewModel.answers as Any)
            case .failure:
                print("There was an error with downloading answers!")
            default:
                break
            }
        })
    }

}
