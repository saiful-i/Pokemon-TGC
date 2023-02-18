//
//  ViewModel.swift
//  Pokemon TGC
//
//  Created by Saiful Islam on 16/02/23.
//

import Foundation
import RxSwift

class ViewModel: BaseViewModel {
    var cards = BehaviorDriver<[CardModel]>(value: [])
    var name = ""
    var page = 1
    
    func getCards(name: String = "") {
        self.name = name
        cards.accept([])
        page = 1
        BaseApi.shared.cancelRequest(url: ListUrls.CARDS)
        BaseApi.shared.getCards(name: name) { [weak self] cards in
            guard let self = self else {
                return
            }
            self.cards.accept(cards)
            self.page = cards.count
        }
    }
    
    func loadMore() {
        isLoading.accept(true)
        var tempCards = cards.value()
        BaseApi.shared.getCards(name: name, page: page) { [weak self] cards in
            guard let self = self else {
                return
            }
            self.isLoading.accept(false)
            tempCards.append(contentsOf: cards)
            self.cards.accept(tempCards)
            self.page = cards.count
        }
    }
}
