//
//  KVOController.swift
//  KVOControllerForSwiftDemo
//
//  Created by Marshal on 2021/12/21.
//

import UIKit

typealias LLBlock = (Any, Any) -> Void

//注意如果不是仅仅用来当数据的，不要轻易使用 struct，限制很大
class __LLKVOInfo: NSObject {
    weak var observer: AnyObject?
    var block: LLBlock
    var keyPath: String
    
    init(observer: AnyObject, block: @escaping LLBlock, keyPath: String) {
        self.observer = observer
        self.block = block
        self.keyPath = keyPath
    }
    
    func hash() -> Int {
        return Int(self.keyPath.hash)
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        if let obj = object as? __LLKVOInfo {
            if obj.keyPath == self.keyPath {
                return true
            }
        }
        return false
    }
    
    deinit {
        print("__LLKVOInfo释放了")
    }
}

class LLKVOController: NSObject {
    var infosMap: NSMapTable<AnyObject, NSMutableSet>
    var semaphore: DispatchSemaphore
    
    override init() {
        infosMap = NSMapTable(keyOptions: [.strongMemory, .objectPointerPersonality], valueOptions: [.strongMemory, .objectPointerPersonality])
        semaphore = DispatchSemaphore(value: 1)
    }

    func observer(_ observedObj: AnyObject, _ keyPath: String, _ block: @escaping LLBlock) {
        let info = __LLKVOInfo(observer: observedObj, block: block, keyPath: keyPath)
        
        semaphore.wait()
        var infoSet = infosMap.object(forKey: observedObj)
        
        if let set = infoSet {
            if set.contains(info) {
                //已经添加观察了，不再添加
                semaphore.signal()
                return
            }
        }else {
            infoSet = NSMutableSet()
            infosMap.setObject(infoSet, forKey: observedObj)
        }
        
        //添加新内容
        infoSet?.add(info)
        
        semaphore.signal()
        //添加观察
        observedObj.addObserver(self, forKeyPath: keyPath, options: [.new, .old], context: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        let obj = object as AnyObject
        if let infoSet = self.infosMap.object(forKey: obj) {
            for info in infoSet {
                if let info = info as? __LLKVOInfo {
                    if (info.keyPath == keyPath) {
                        info.block(change?[NSKeyValueChangeKey.newKey] as Any, obj)
                        return
                    }
                }
            }
        }
    }
    
    func unobserver(_ observedObj: AnyObject) {
        if let obj = self.infosMap.object(forKey: observedObj) {
            for info in obj {
                observedObj.removeObserver(self, forKeyPath: (info as! __LLKVOInfo).keyPath)
            }
            self.infosMap.removeObject(forKey: observedObj)
        }
    }
    
    func unobserver(_ observedObj: AnyObject, _ keyPath: String) {
        if let obj = self.infosMap.object(forKey: observedObj) {
            for info in obj {
                if (info as! __LLKVOInfo).keyPath == keyPath {
                    observedObj.removeObserver(self, forKeyPath: keyPath)
                    if obj.count < 2 {
                        self.infosMap.removeObject(forKey: observedObj)
                    }else {
                        obj.remove(info)
                    }
                    return
                }
            }
        }
    }
    
    deinit {
        for observer in self.infosMap.keyEnumerator() {
            let observed = observer as AnyObject
            let obj = self.infosMap.object(forKey: observed)
            for info in obj! {
                observed.removeObserver(self, forKeyPath: (info as! __LLKVOInfo).keyPath)
            }
        }
        print("KVOController释放了")
    }
}
