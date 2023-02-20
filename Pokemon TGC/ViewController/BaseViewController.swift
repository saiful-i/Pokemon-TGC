//
//  BaseViewController.swift
//  Pokemon TGC
//
//  Created by Saiful Islam on 16/02/23.
//

import UIKit
import RxSwift

class BaseViewController: UIViewController {
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        registerObserver()
    }
    
    func registerObserver() {
        
    }
}
