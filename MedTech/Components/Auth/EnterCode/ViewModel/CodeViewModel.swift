//
//  CodeViewModel.swift
//  MedTech
//
//  Created by Eldiiar on 6/7/22.
//

import Foundation

protocol CodeViewModelProtocol {
    func enterCode(code: String, completion: @escaping ((SuccessFailure?) -> Void))
    var code: CodeModel? { get set }
}

class CodeViewModel: CodeViewModelProtocol {
    
    var code: CodeModel?
    
    let networkService: NetworkService = NetworkService()
    
    private let service: CodeServiceProtocol
    private let userDefaults = UserDefaultsService()
    
    init(vm: CodeServiceProtocol = CodeService()) {
        service = vm
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func enterCode(code: String, completion: @escaping ((SuccessFailure?) -> Void)) {
        service.enterCode(code: code) { result in
            guard result?.id != nil else {
                completion(.failure)
                return
            }
            self.code = result
            completion(.success)
        }
    }
}
