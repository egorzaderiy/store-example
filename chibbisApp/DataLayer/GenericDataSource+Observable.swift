//
//  GenericDataSource.swift
//  chibbisApp
//
//  Created by Egor Zaderiy on 16.10.2021.
//

import Foundation

typealias Completion = (() -> Void)
class ObservableValue<T> {
    
    private var observers = [String: Completion]()

    var val: T {
        didSet {
            self.notify()
        }
    }

    // MARK: - Init
    
    init(_ val: T) {
        self.val = val
    }

    // MARK: - Observers
    
    func addObserver(_ observer: AnyObject, callback: @escaping Completion) {
        observers[observer.description] = callback
    }

    func addAndNotify(observer: AnyObject, callback: @escaping Completion) {
        addObserver(observer, callback: callback)
        notify()
    }

    private func notify() {
        observers.forEach({ $0.value() })
    }

    deinit {
        observers.removeAll()
    }
}

class GenericDataSource<T>: NSObject {
    var data: ObservableValue<[T]> = ObservableValue([])
}
