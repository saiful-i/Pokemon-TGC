//
//  BaseViewModel.swift
//  Pokemon TGC
//
//  Created by Saiful Islam on 16/02/23.
//

import RxSwift

class BaseViewModel: NSObject {
    var isLoading = BehaviorDriver<Bool>(value: false)
    
    required override init() {
        super.init()
    }
}
