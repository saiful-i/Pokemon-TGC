//
//  DetailCardViewModel.swift
//  Pokemon TGC
//
//  Created by Saiful Islam on 18/02/23.
//

import Foundation
import RxSwift
import RxCocoa
import NetworkModule

class DetailCardViewModel: BaseViewModel {
    var card = BehaviorDriver<CardModel?>(value: nil)
    var otherCards = BehaviorDriver<[CardModel]>(value: [])
    
    func getDetailCard(id: String) {
        isLoading.accept(true)
        BaseApi.shared.getCard(id: id) { [weak self] card in
            guard let self = self, let card = card else {
                return
            }
            
            self.card.accept(card)
            self.isLoading.accept(false)
        }
    }
    
    func getOtherCards(id: String) {
        isLoading.accept(true)
        BaseApi.shared.getOtherCards(id: id) { [weak self] cards in
            guard let self = self else {
                return
            }
            self.otherCards.accept(cards)
            self.isLoading.accept(false)
        }
    }
}
