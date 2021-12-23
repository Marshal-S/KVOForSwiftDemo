//
//  ViewController.swift
//  KVOControllerForSwiftDemo
//
//  Created by Marshal on 2021/12/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.createUI()
    }

    func createUI() {
        let names = ["baseKVO", "KVOController", "KVOObserver"]
        let funcs = ["testBaseKVOController", "testKVOCtlController", "TestObserverCOntroller"]
        for index in 0...2 {
            
            let btn = UIButton(frame: CGRect(x: 0, y: 100 + 60 * index, width: Int(self.view.bounds.size.width), height: 40))
            btn.setTitle(names[index], for: .normal)
            btn.setTitleColor(UIColor.black, for: .normal)
            self.view.addSubview(btn)
            
            //添加点击事件
            // NSSelectorFromString("function")
            // #selector(self.function) //#selector(类名.事件方法)
            //UIKit框架仍然是使用的OC，因此只能识别OC的方法，调用的方法前面需要 @objc 修饰
            btn.addTarget(self, action: Selector(funcs[index]), for: .touchUpInside)
            
            //下面系统自己的方法，由于ios版本限制问题，不建议使用
            //btn.addAction(UIAction(handler: { (action) in  "响应一下" }), for: .touchUpInside)
        }
    }
    
    //如果不是swift中直接调用，使用的系统库响应的或者其他OC库调用，前面要加上@objc，oc方法才能识别
    @objc func testBaseKVOController() {
        let vc = KVOBaseTestController()
        self.present(vc, animated: true, completion: nil)
    }
    
    @objc func testKVOCtlController() {
        let vc = KVOControllerTestController()
        self.present(vc, animated: true, completion: nil)
    }
    
    @objc func TestObserverCOntroller() {
        let vc = KVOObserverController()
        self.present(vc, animated: true, completion: nil)
    }

}

