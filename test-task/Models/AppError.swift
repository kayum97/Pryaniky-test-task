//
//  AppError.swift
//  test-task
//
//  Created by Admin on 15.02.2021.
//

import Foundation

enum AppError: String, Error {
    case urlError = "Invalid URL"
    case decodeError = "Decode Error"
    case dataError = "Error Data"
}
