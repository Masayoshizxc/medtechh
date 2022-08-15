//
//  MoreMoreChecklistViewController.swift
//  MedTech
//
//  Created by Eldiiar on 31/7/22.
//

import UIKit

class QuestionAnswerViewController: BaseViewController {
        
    private let viewModel: ChecklistViewModelProtocol
    var checklist: ChecklistModel?
    
    init(vm: ChecklistViewModelProtocol = ChecklistViewModel()) {
        viewModel = vm
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let checklist = checklist, let id = checklist.id else {
            return
        }

        viewModel.getAnswers(id: id, completion: { result in
            switch result {
            case .success:
                print(checklist.basic_questions)
                print(self.viewModel.answers as Any)
            case .failure:
                print("There was an error with downloading answers!")
            default:
                break
            }
        })
    }

}
