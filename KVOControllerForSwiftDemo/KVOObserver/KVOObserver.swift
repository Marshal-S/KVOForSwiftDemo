//
//  KVOObserver.swift
//  KVOControllerForSwiftDemo
//
//  Created by Marshal on 2021/12/21.
//  一个简单的属性包装KVO案例

import UIKit

typealias LLObserverBlock = (Any) -> Void

@propertyWrapper
struct LLObserver<T> {
    private var observerValue: T? //记得设置初值，也可以通过init来设置
    private var block: LLObserverBlock?
    //默认的属性包装名称，参数名固定
    var wrappedValue: T? {
        get {observerValue}
        set {
            observerValue = newValue
            if let b = block {
                b(newValue as Any)
            }
        }
    }
    //属性映射名称，参数名固定(这里模拟写入数据库操作)，调用参数时前面加上$即可(obj.$number)
    var projectedValue: LLObserverBlock {
        get {
            block!
        }
        set {
            block = newValue
        }
    }
    
    init() {
        observerValue = nil
        block = nil
    }
}
