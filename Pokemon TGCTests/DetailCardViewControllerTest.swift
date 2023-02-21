//
//  DetailCardViewControllerTest.swift
//  Pokemon TGCTests
//
//  Created by Saiful Islam on 21/02/23.
//

import Quick
import Nimble
@testable import Pokemon_TGC

class DetailCardViewControllerTest: QuickSpec {
    override func spec() {
        var sut: DetailCardViewController!
        var navigationController: UINavigationController?
        
        beforeEach {
            sut = DetailCardViewController()
            navigationController = UINavigationController()
            let window = UIWindow(frame: UIScreen.main.bounds)
            window.makeKeyAndVisible()
            window.rootViewController = navigationController
            _ = sut?.view
            _ = navigationController?.view
            if let vc = sut {
                navigationController?.pushViewController(vc, animated: false)
            }
        }
        
        afterEach {
            sut = nil
            navigationController = nil
        }
        
        describe("ViewController") {
            context("setup text field") {
                it("should setup text field") {
                    
                    sut.viewDidLoad()
                }
            }
            
            context("register observer") {
                it("it should bind data") {
                    let card = CardModel(
                        name: "name",
                        id: "id",
                        images: ImageModel(
                            small: "small",
                            large: "large"),
                        types: ["types"],
                        hp: "hp",
                        supertype: "supertype",
                        subtypes: ["subtype"],
                        flavorText: "flavortext",
                        setModel: SetModel(
                            id: "id"
                        )
                    )
                    
                    sut.viewDidLoad()
                    sut.viewModel?.card.accept(card)
                    
                    expect(sut.nameLabel.text).to(equal("name"))
                    expect(sut.hpAndTypesLabel.text).to(equal("types (hp)"))
                    expect(sut.superTypeAndSubTypeLabel.text).to(equal("subtype - subtype"))
                    expect(sut.flavorTitleLabel.text).to(equal("Flavor:"))
                    expect(sut.flavorDescriptionLabel.text).to(equal("flavortext"))
                    expect(sut.otherCardLabel.text).to(equal("Other Cards"))
                }
                
                it("it should reload and bind collection view") {
                    let card = CardModel(
                        name: "name",
                        id: "id",
                        images: ImageModel(
                            small: "small",
                            large: "large"),
                        types: ["types"],
                        hp: "hp",
                        supertype: "supertype",
                        subtypes: ["subtype"],
                        flavorText: "flavortext",
                        setModel: SetModel(
                            id: "id"
                        )
                    )
                    
                    sut.viewDidLoad()
                    sut.viewModel?.otherCards.accept([card])
                    
                    let index = IndexPath(item: 0, section: 0)
                    let collection = sut.collectionView
                    let collectionView = sut.collectionView(collection, cellForItemAt: index)
                    
                    expect(collectionView).to(beAKindOf(CardCollectionViewCell.self))
                }
            }
            
            context("collection data source delegate") {
                it("didSelectItemAt") {
                    let card = CardModel(
                        name: "name",
                        id: "id",
                        images: ImageModel(
                            small: "small",
                            large: "large"),
                        types: ["types"],
                        hp: "hp",
                        supertype: "supertype",
                        subtypes: ["subtype"],
                        flavorText: "flavortext",
                        setModel: SetModel(
                            id: "id"
                        )
                    )
                        
                    sut.viewDidLoad()
                    sut.viewModel?.otherCards.accept([card])
                    
                    let collection = sut.collectionView
                    sut.collectionView(collection, didSelectItemAt: IndexPath(row: 0, section: 0))
                    
                    expect(sut.navigationController?.viewControllers.last).toEventually(beAKindOf(DetailCardViewController.self), timeout: .seconds(30))
                }
            }
            
            context("gesture") {
                it("should present DetailPhotoViewController") {
                    sut.onImageTapped()
                    
                    expect(sut.presentedViewController).toEventually(beAKindOf(DetailPhotoViewController.self), timeout: .seconds(30))
                }
            }
        }
    }
}
