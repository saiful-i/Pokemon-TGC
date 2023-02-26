//
//  ImageModel.swift
//  Pokemon TGC
//
//  Created by Saiful Islam on 16/02/23.
//

import Foundation

public struct ImageModel {
    public let small: String
    public let large: String
    
    enum CodingKeys: String, CodingKey {
        case small, large
    }
}

extension ImageModel: Decodable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        small = try container.decode(String.self, forKey: .small)
        large = try container.decode(String.self, forKey: .large)
    }
}
