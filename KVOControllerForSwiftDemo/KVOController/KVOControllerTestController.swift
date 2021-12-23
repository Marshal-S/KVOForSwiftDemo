//
//  KVOControllerTestController.swift
//  KVOControllerForSwiftDemo
//
//  Created by Marshal on 2021/12/21.
//  模仿KVOController的测试案例

import UIKit

var sharedModel = KVOCtlTestModel()

class KVOControllerTestController: UIViewController {
    var kvoModel: KVOCtlTestModel?
    var kvoController: LLKVOController?
    
    var btn: UIButton?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        self.createUI()
        
        sharedModel.name = "123"
        
        kvoController = LLKVOController()
        
        kvoModel = KVOCtlTestModel()
        kvoModel!.name = "哈哈"
        
        kvoController?.observer(kvoModel!, "name") { [unowned self] newValue, object in
            print("kvoModel:name", newValue)
        }
        kvoController?.observer(sharedModel, "name") { [unowned self] newValue, object in
            print("sharedModel:name", newValue)
        }
        kvoController?.observer(kvoModel!, "age") { [unowned self] newValue, object  in
            print("kvoModel:age", newValue)
        }
//        kvoController?.unobserver(sharedModel)
//        kvoController?.unobserver(kvoModel!, "age")
    }
    
    func createUI() {
        btn = UIButton(frame: CGRect(x: 0, y: 100, width: self.view.bounds.size.width, height: 40))
        btn!.setTitle("点击测试一下KVO", for: .normal)
        btn!.setTitleColor(UIColor.black, for: .normal)
        btn?.addTarget(self, action: #selector(self.onClickToModify), for: .touchUpInside)
        self.view.addSubview(btn!)
    }
    
    @objc func onClickToModify() {
        kvoModel?.name = "啊啊哈哈哈哈1"
        kvoModel?.age = 10
        if let name = sharedModel.name {
            sharedModel.name =  name + "1"
        }else {
            sharedModel.name = "1"
        }
    }
    
    deinit {
        print("KVOControllerTestController释放了")
    }

}
