//
//  DetailCardViewModel.swift
//  Pokemon TGC
//
//  Created by Saiful Islam on 18/02/23.
//

import Foundation
import RxSwift
import RxCocoa

class DetailCardViewModel: BaseViewModel {
    var card = BehaviorDriver<CardModel?>(value: nil)
    var otherCards = BehaviorDriver<[CardModel]>(value: [])
    
    func getDetailCard(id: String) {
        BaseApi.shared.getCard(id: id) { [weak self] card in
            guard let self = self, let card = card else {
                return
            }
            
            self.card.accept(card)
        }
    }
    
    func getOtherCards(id: String) {
        BaseApi.shared.getOtherCards(id: id) { [weak self] cards in
            guard let self = self else {
                return
            }
            self.otherCards.accept(cards)
        }
    }
}
