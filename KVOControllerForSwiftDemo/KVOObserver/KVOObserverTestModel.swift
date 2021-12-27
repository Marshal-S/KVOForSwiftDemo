//
//  KVOObserverTestModel.swift
//  KVOControllerForSwiftDemo
//
//  Created by Marshal on 2021/12/21.
//

import UIKit

class KVOObserverTestModel: NSObject {
    @LLObserver
    var age: UInt?
    
    @LLObserver
    var name: String?
    
    deinit {
        print("KVOObserverTestModel释放了")
    }
}

