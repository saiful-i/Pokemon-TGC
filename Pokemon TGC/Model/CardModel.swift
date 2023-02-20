//
//  CardModel.swift
//  Pokemon TGC
//
//  Created by Saiful Islam on 16/02/23.
//

import Foundation

struct CardModel {
    let name: String?
    let id: String?
    let images: ImageModel?
    let types: [String]?
    let hp: String?
    let supertype: String?
    let subtypes: [String]?
    let flavorText: String?
    let setModel: SetModel?
    
    enum CodingKeys: String, CodingKey {
        case name, id, images, types, hp, supertype, subtypes, flavorText, set
    }
}

extension CardModel: Decodable {
    init(from decoder: Decoder) throws {
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
