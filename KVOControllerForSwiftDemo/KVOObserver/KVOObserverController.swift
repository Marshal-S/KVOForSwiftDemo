//
//  KVOObserverController.swift
//  KVOControllerForSwiftDemo
//
//  Created by Marshal on 2021/12/21.
//  使用swift特性属性包装生成的KVO测试

import UIKit

class KVOObserverController: UIViewController {
    
    var observerModel: KVOObserverTestModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        self.createUI()
        
        observerModel = KVOObserverTestModel()
        //设置监听
        observerModel?.$name = { newValue in
            print("name", newValue)
        }
        observerModel?.$age = { newValue in
            print("age", newValue)
        }
    }
    
    func createUI() {
        let btn = UIButton(frame: CGRect(x: 0, y: 100, width: self.view.bounds.size.width, height: 40))
        btn.setTitle("点击测试一下KVO", for: .normal)
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.addTarget(self, action: #selector(self.onClickToModify), for: .touchUpInside)
        self.view.addSubview(btn)
    }
    
    @objc func onClickToModify() {
        observerModel?.name = "啊哈哈哈哈哈"
        observerModel?.age = 30
    }
    
    deinit {
        print("KVOObserverController释放了")
    }

}
