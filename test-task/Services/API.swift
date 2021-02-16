//
//  API.swift
//  test-task
//
//  Created by Admin on 14.02.2021.
//

import Foundation
import Alamofire
import RxSwift

class API {
    
    private let baseUrl = "https://pryaniky.com/static/json/"
    private let noteUrl = "sample.json"
    
    func loadData() -> Observable<ResponseModel> {
        guard let url = URL(string: baseUrl + noteUrl) else {
            return .error(AppError.urlError)
        }
        
        return Observable.create { observer in
            AF.request(url).response { response in
                if let data = response.data {
                    guard let dataArray = Parser().parseFromJson(data: data) else {
                        observer.onError(AppError.decodeError)
                        return
                    }
                    observer.onNext(dataArray)
                } else {
                    observer.onError(AppError.dataError)
                }
            }
            return Disposables.create {}
        }
    }
}
