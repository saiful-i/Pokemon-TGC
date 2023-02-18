//
//  CardModel.swift
//  Pokemon TGC
//
//  Created by Saiful Islam on 16/02/23.
//

import Foundation

struct CardModel {
    let name: String
    let id: String
    let images: ImageModel
    
    enum CodingKeys: String, CodingKey {
        case name, id, images
    }
}

extension CardModel: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        id = try container.decode(String.self, forKey: .id)
        images = try container.decode(ImageModel.self, forKey: .images)
    }
}
