//
//  DetailPhotoViewControllerTest.swift
//  Pokemon TGCTests
//
//  Created by Saiful Islam on 21/02/23.
//

import Quick
import Nimble
@testable import Pokemon_TGC

final class DetailPhotoViewControllerTest: QuickSpec {
    override func spec() {
        var sut: DetailPhotoViewController!
        var controller: UIViewController!
        
        beforeEach {
            sut = DetailPhotoViewController()
            controller = UIViewController()
            _ = controller?.view
            _ = sut?.view
            let window = UIWindow(frame: UIScreen.main.bounds)
            window.makeKeyAndVisible()
            window.rootViewController = controller
            controller.present(sut, animated: false)
        }
        
        afterEach {
            controller.presentedViewController?.dismiss(animated: false, completion: nil)
            sut = nil
            controller = nil
        }
        
        describe("DetailPhotoViewController") {
            context("setuo view") {
                it("should setup view") {
                    sut.viewDidLoad()
                    
                    expect(sut.scrollView.contentSize).to(equal(UIScreen.main.bounds.size))
                    expect(sut.scrollView.showsHorizontalScrollIndicator).to(beFalse())
                    expect(sut.scrollView.showsVerticalScrollIndicator).to(beFalse())
                    expect(sut.scrollView.maximumZoomScale).to(equal(4.0))
                    expect(sut.scrollView.minimumZoomScale).to(equal(1.0))
                    
                    expect(sut.imageView.clipsToBounds).to(beTrue())
                    expect(sut.imageView.contentMode).to(equal(UIView.ContentMode.scaleAspectFit))
                    expect(sut.imageView.frame).to(equal(CGRect(x: 16, y: 0, width: sut.view.frame.width - 32, height: sut.view.frame.height)))
                }
            }
        }
        
        describe("didTapDismissButton") {
            it("should dismiss view controller") {
                sut.didTapDismissButton()
                
                expect(sut.isBeingDismissed).toEventually(beTrue(), timeout: .seconds(15))
            }
        }
        
        describe("UIScrollViewDelegate") {
            it("should viewForZooming return imageView") {
                let result = sut.viewForZooming(in: sut.scrollView)
                
                expect(result).to(equal(sut.imageView))
            }
            
            it("should scroll view did zoom") {
                sut.scrollViewDidZoom(sut.scrollView)
                
                expect(sut.scrollView.contentInset).to(equal(UIEdgeInsets.zero))
                expect(sut.scrollView.zoomScale).to(equal(1.0))
                
                sut.imageView.image = UIImage(systemName: "multiply.circle.fill")
                sut.scrollView.zoomScale = 2
                sut.scrollViewDidZoom(sut.scrollView)
            }
        }
    }
}
