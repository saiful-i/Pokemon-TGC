//
//  SetModel.swift
//  Pokemon TGC
//
//  Created by Saiful Islam on 19/02/23.
//

import Foundation

public struct SetModel {
    public let id: String
    
    enum CodingKeys: String, CodingKey {
        case id
    }
}

extension SetModel: Decodable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
    }
}
