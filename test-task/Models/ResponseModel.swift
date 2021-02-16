//
//  MainModel.swift
//  test-task
//
//  Created by Admin on 14.02.2021.
//

import Foundation

struct ResponseModel: Decodable {
    var data: [DataModel]
    var view: [ViewModel]
}

enum DataType: String, Decodable {
    case hz
    case picture
    case selector
    case unknown
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let name = try container.decode(String.self)
        self = DataType(rawValue: name) ?? .unknown
    }
}

enum DataModel: Decodable {
    
    case hz(TextModel)
    case picture(PictureModel)
    case selector(SelectorModel)
    case unknown
    
    var dataType: DataType {
        switch (self) {
        case .hz:
            return .hz
        case .picture:
            return .picture
        case .selector:
            return .selector
        case .unknown:
            return .unknown
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case name
        case data
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        guard let name = try? container.decode(DataType.self, forKey: .name) else {
            self = .unknown
            return
        }
        
        switch name {
        case .hz:
            if let hz = try? container.decode(TextModel.self, forKey: .data) {
                self = .hz(hz)
            } else {
                self = .unknown
            }
        case .picture:
            if let picture = try? container.decode(PictureModel.self, forKey: .data) {
                self = .picture(picture)
            } else {
                self = .unknown
            }
        case .selector:
            if let selector = try? container.decode(SelectorModel.self, forKey: .data) {
                self = .selector(selector)
            } else {
                self = .unknown
            }
        case .unknown:
            self = .unknown
        }
    }
}

struct TextModel: Decodable {
    var text: String
}

struct PictureModel: Decodable {
    var text: String
    var url: String
}

struct SelectorModel: Decodable {
    var selectedId: Int
    var variants: [VariantsModel]
}

struct VariantsModel: Decodable {
    var id: Int
    var text: String
}

enum ViewModel: String, Decodable {
    case hz, selector, picture
}
