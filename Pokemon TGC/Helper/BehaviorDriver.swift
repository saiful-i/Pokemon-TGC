//
//  BehaviorDriver.swift
//  Pokemon TGC
//
//  Created by Saiful Islam on 16/02/23.
//

import RxSwift
import RxCocoa

public class BehaviorDriver<Element>: NSObject {
    
    var behavior: BehaviorRelay<Element>!
    var driver: Driver<Element> {
        return behavior.asDriver()
    }

    public init(value: Element) {
       behavior =  BehaviorRelay<Element>(value: value)
    }
    
    public func value()->Element {
        return behavior.value
    }
    
    public func accept(_ event: Element) {
        behavior.accept(event)
    }
    
    public func drive(onNext: ((Element) -> Void)? = nil, onCompleted: (() -> Void)? = nil, onDisposed: (() -> Void)? = nil) -> Disposable {
        
        return driver.drive(onNext: onNext, onCompleted: onCompleted, onDisposed: onDisposed)
    }
    
    public func drive<Observer>(_ observer: Observer) -> Disposable where Observer : ObserverType, Element == Observer.Element {
        return driver.drive(observer)
    }
}
