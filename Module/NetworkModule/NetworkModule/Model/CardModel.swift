//
//  CardModel.swift
//  Pokemon TGC
//
//  Created by Saiful Islam on 16/02/23.
//

import Foundation

public struct CardModel {
    public let name: String?
    public let id: String?
    public let images: ImageModel?
    public let types: [String]?
    public let hp: String?
    public let supertype: String?
    public let subtypes: [String]?
    public let flavorText: String?
    public let setModel: SetModel?
    
    enum CodingKeys: String, CodingKey {
        case name, id, images, types, hp, supertype, subtypes, flavorText, set
    }
}

extension CardModel: Decodable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decodeIfPresent(String.self, forKey: .name)
        id = try container.decodeIfPresent(String.self, forKey: .id)
        images = try container.decodeIfPresent(ImageModel.self, forKey: .images)
        types = try container.decodeIfPresent([String].self, forKey: .types)
        hp = try container.decodeIfPresent(String.self, forKey: .hp)
        supertype = try container.decodeIfPresent(String.self, forKey: .supertype)
        subtypes = try container.decodeIfPresent([String].self, forKey: .subtypes)
        flavorText = try container.decodeIfPresent(String.self, forKey: .flavorText)
        setModel = try container.decodeIfPresent(SetModel.self, forKey: .set)
    }
}
