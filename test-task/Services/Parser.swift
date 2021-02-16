//
//  Parser.swift
//  test-task
//
//  Created by Admin on 14.02.2021.
//

import Foundation
import RxSwift

class Parser {
    func parseFromJson(data: Data) -> ResponseModel? {
        do {
            let parsedResult = try JSONDecoder().decode(ResponseModel.self, from: data)
            return parsedResult
        } catch {
            print("Error during JSON serialization: \(error.localizedDescription)")
            return nil
        }
    }
}
