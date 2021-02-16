//
//  SandboxViewModel.swift
//  test-task
//
//  Created by Admin on 15.02.2021.
//

import Foundation
import RxSwift
import RxCocoa

protocol SandboxViewModelProtocol: class {
    var dictionaryRelay: BehaviorRelay<[String:Any]> { get }
    var viewRelay: BehaviorRelay<[ViewModel]>  { get }
    var errorSubject: PublishSubject<Error> { get }
    func loadData()
}

class SandboxViewModel: SandboxViewModelProtocol {
    let dictionaryRelay = BehaviorRelay<[String:Any]>(value: [:])
    let viewRelay = BehaviorRelay<[ViewModel]>(value: [])
    let errorSubject = PublishSubject<Error>()
    
    private var service = API()
    private let disposeBag = DisposeBag()
    
    func loadData() {
        service.loadData()
            .catch { error in
                self.errorSubject.onNext(error)
                return .empty()
            }
            .bind{ [weak self] value in
                self?.viewRelay.accept(value.view)
                self?.setData(result: value.data)
            }
            .disposed(by: disposeBag)
    }
    
    private func setData(result: [DataModel]?) {
        guard let result = result else { return }
        var dictionary: [String:Any] = [:]
        for item in result {
            switch item {
            case .hz(let data):
                dictionary[item.dataType.rawValue] = data
            case .picture(let data):
                dictionary[item.dataType.rawValue] = data
            case .selector(let data):
                dictionary[item.dataType.rawValue] = data
            case .unknown:
                continue
            }
        }
        self.dictionaryRelay.accept(dictionary)
    }
}
