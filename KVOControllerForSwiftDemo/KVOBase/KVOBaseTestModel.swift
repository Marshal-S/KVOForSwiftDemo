//
//  KVOBaseTestModel.swift
//  KVOControllerForSwiftDemo
//
//  Created by Marshal on 2021/12/21.
//

import UIKit

class KVOBaseTestModel: NSObject {
    //必须要添加 @objc dynamic 参数才可以支持监听
    //且由于OC中没有可选类型，如果基本数据类型出现了可选类型会报错，毕竟基本类型不能赋值为nil
    @objc dynamic var age: Int = 0
    @objc dynamic var name: String?
}
