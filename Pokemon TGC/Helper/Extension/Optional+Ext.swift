//
//  Optional+Ext.swift
//  Pokemon TGC
//
//  Created by Saiful Islam on 21/02/23.
//

import Foundation

extension Optional {
    func ifNil(_ then: Wrapped) -> Wrapped {
        switch self {
        case .none: return then
        case let .some(value): return value
        }
    }
}
