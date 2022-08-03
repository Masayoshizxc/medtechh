//
//  MoreMoreChecklistViewController.swift
//  MedTech
//
//  Created by Eldiiar on 31/7/22.
//

import UIKit

class QuestionAnswerViewController: BaseViewController {
        
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
            print(result)
        })
    }

}
