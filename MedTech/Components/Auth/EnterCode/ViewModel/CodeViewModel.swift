//
//  CodeViewModel.swift
//  MedTech
//
//  Created by Eldiiar on 6/7/22.
//

import Foundation

protocol CodeViewModelProtocol {
    func enterCode(code: String, completion: @escaping ((CodeModel?) -> Void))
}

class CodeViewModel: CodeViewModelProtocol {
    let networkService: NetworkService = NetworkService()
    
    private let service: CodeServiceProtocol
    private let userDefaults = UserDefaultsService()
    
    init(vm: CodeServiceProtocol = CodeService()) {
        service = vm
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func enterCode(code: String, completion: @escaping ((CodeModel?) -> Void)) {
        service.enterCode(code: code) { result in
            completion(result)
        }
    }
}
