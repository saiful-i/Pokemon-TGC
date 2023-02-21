//
//  BaseViewController.swift
//  Pokemon TGC
//
//  Created by Saiful Islam on 16/02/23.
//

import UIKit
import RxSwift

class BaseViewController<D: BaseViewModel> : UIViewController {
    let disposeBag = DisposeBag()
    var viewModel: D?
    
    lazy var loadingView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupViewModel()
        setupLoadingView()
        registerObserver()
    }
    
    func registerObserver() {
        viewModel?.isLoading.driver.throttle(.microseconds(500), latest: true).drive(onNext: { [weak self] isLoading in
            guard let self = self else {
                return
            }
            
            self.isShowLoading(isLoading)
        }).disposed(by: disposeBag)
    }
}

extension BaseViewController {
    private func setupViewModel() {
        if viewModel == nil {
            viewModel = D()
        }
    }
    
    private func setupLoadingView() {
        guard let view = view else {
            return
        }
        
        loadingView.stopAnimating()
        loadingView.color = UIColor.black
        loadingView.hidesWhenStopped = true
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(loadingView)
        
        loadingView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loadingView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    private func isShowLoading(_ isLoading: Bool) {
        isLoading ? loadingView.startAnimating() : loadingView.stopAnimating()
    }
    
    func bringLoadingViewsToFront() {
        view.bringSubviewToFront(loadingView)
    }
}
