//
//  KVOBaseTestController.swift
//  KVOControllerForSwiftDemo
//
//  Created by Marshal on 2021/12/21.
//  基本KVO测试案例

import UIKit

class KVOBaseTestController: UIViewController {
    
    var baseModel: KVOBaseTestModel?
    var kvoToken: NSKeyValueObservation?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        self.createUI()
        
        self .addObaserver()
    }
    
    func createUI() {
        let btn = UIButton(frame: CGRect(x: 0, y: 100, width: self.view.bounds.size.width, height: 40))
        btn.setTitle("点击测试一下KVO", for: .normal)
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.addTarget(self, action: #selector(self.onClickToModify), for: .touchUpInside)
        self.view.addSubview(btn)
    }
    
    func addObaserver() {
        baseModel = KVOBaseTestModel()
        
        //同一个对象，同一个键值也可以观察两次，则也会响应两次
        baseModel?.addObserver(self, forKeyPath: "name", options: [.new, .old], context: nil)
        baseModel?.addObserver(self, forKeyPath: "name", options: [.new, .old], context: nil)
        
        baseModel?.addObserver(self, forKeyPath: "age", options: [.new, .old], context: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        print(change as Any)
    }
    
    @objc func onClickToModify() {
        baseModel?.name = "哈哈哈哈啥打法上的发"
        baseModel?.age = 200
    }

    deinit {
        kvoToken?.invalidate()
        print("KVOBaseTestController释放了")
    }
    
    
}
