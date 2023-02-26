//
//  ViewControllerTest.swift
//  Pokemon TGCTests
//
//  Created by Saiful Islam on 21/02/23.
//

import Quick
import Nimble
@testable import Pokemon_TGC
@testable import NetworkModule

final class ViewControllerTest: QuickSpec {
    override func spec() {
        var sut: ViewController!
        var navigationController: UINavigationController?
        
        beforeEach {
            sut = ViewController()
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
                    sut.viewModel?.cards.accept([card])
                    
                    let index = IndexPath(item: 0, section: 0)
                    let collection = sut.collectionView
                    let collectionView = sut.collectionView(collection, cellForItemAt: index)
                    
                    expect(collectionView).to(beAKindOf(CardCollectionViewCell.self))
                }
            }
            
            context("setup text field") {
                it("should setup text field") {
                    sut.viewDidLoad()
                    
                    expect(sut.textField.layer.borderColor).to(equal(UIColor.gray.cgColor))
                    expect(sut.textField.layer.borderWidth).to(equal(1))
                    expect(sut.textField.layer.cornerRadius).to(equal(8))
                    expect(sut.textField.placeholder).to(equal("Search Pokemon"))
                    expect(sut.textField.returnKeyType).to(equal(UIReturnKeyType.done))
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
                    sut.viewModel?.cards.accept([card])
                    
                    let collection = sut.collectionView
                    sut.collectionView(collection, didSelectItemAt: IndexPath(row: 0, section: 0))
                    
                    expect(sut.navigationController?.viewControllers.last).toEventually(beAKindOf(DetailCardViewController.self), timeout: .seconds(30))
                }
            }
            
            context("text field did end editing") {
                it("should load api") {
                    sut.textFieldDidEndEditing(sut.textField)
                    
                    expect(sut.viewModel?.isLoading.value()).to(beTrue())
                }
            }
            
            context("scroll view did end decelerating") {
                it("should load more card") {
                    sut.viewModel?.isLoading.accept(false)
                    sut.scrollViewDidEndDecelerating(sut.collectionView)
                    
                    expect(sut.viewModel?.isLoading.value()).to(beTrue())
                }
            }
            
            context("textFieldShouldReturn") {
                it("should resign first responder text field") {
                    sut.textField.resignFirstResponder()
                    
                    expect(sut.textFieldShouldReturn(sut.textField)).to(beFalse())
                }
            }
        }
    }
}
