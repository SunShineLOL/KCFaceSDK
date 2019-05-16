//
//  ViewController.swift
//  KCFace_swift_demo
//
//  Created by czn on 2019/5/15.
//  Copyright © 2019 czn. All rights reserved.
//

import UIKit
import KCFace
import SnapKit

//用户标识ID
//let cus = "2d08d3c1b7c14468ab14bf8aca454070"

class ViewController: UIViewController,KCSDKDelegate,UITextFieldDelegate {
    let textView : UITextField! = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //let textView = UITextField();
        textView.placeholder = "(输入cus(数字/字母))"
        textView.delegate = self
        textView.layer.borderColor = UIColor.gray.cgColor
        textView.layer.borderWidth = 0.5
        textView.layer.shadowRadius = 4
        textView.font = .systemFont(ofSize: 18)
        textView.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 1))
        textView.leftViewMode = .always
        self.view.addSubview(textView)
        textView.snp.makeConstraints { (make) in
            make.top.equalTo(100)
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.height.equalTo(50)
        }
        
        let btn = UIButton(type: .custom)
        btn.addTarget(self, action: #selector(btnAction(sender:)), for: .touchUpInside)
        btn.setTitle("启动SDK", for: .normal)
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.titleLabel?.font = .boldSystemFont(ofSize: 18)
        self.view.addSubview(btn)
        
        btn.snp.makeConstraints { (make) in
            make.center.equalTo(self.view)
            make.size.equalTo(CGSize(width: 300, height: 60))
        }
        
        let btn2 = UIButton(type: .custom)
        btn2.addTarget(self, action: #selector(btnAction2(sender:)), for: .touchUpInside)
        btn2.setTitle("获取消费记录", for: .normal)
        btn2.setTitleColor(UIColor.black, for: .normal)
        btn2.titleLabel?.font = .boldSystemFont(ofSize: 18)
        self.view.addSubview(btn2)
        btn2.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.top.equalTo(btn.snp.bottom).offset(20)
            make.size.equalTo(CGSize(width: 300, height: 60))
        }
        
        let btn3 = UIButton(type: .custom)
        btn3.addTarget(self, action: #selector(btnAction3(sender:)), for: .touchUpInside)
        btn3.setTitle("更新免密签名", for: .normal)
        btn3.setTitleColor(UIColor.black, for: .normal)
        btn3.titleLabel?.font = .boldSystemFont(ofSize: 18)
        self.view.addSubview(btn3)
        btn3.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.top.equalTo(btn2.snp.bottom).offset(20)
            make.size.equalTo(CGSize(width: 300, height: 60))
        }
        
        if let cus = UserDefaults.standard.value(forKey: "_cus") {
            self.textView.text = cus as? String ?? ""
        }
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    //获取消费记录
    @objc func btnAction2(sender: UIButton){
        if let text = self.textView.text {
            UserDefaults.standard.set(text, forKey: "_cus")
            UserDefaults.standard.synchronize()
//            //配置SDK参数
//            let manager = KCSDKManager.sharedInstances
//            manager.configSDK("kechong", "\(text)", "", "", "kc", "kechong")
//            //获取消费记录
//            manager.payRecords(0, 0) { (bool, resp) in
//                if bool == true {
//                    //成功
//                    print("成功!\(resp)")
//                }else{
//                    //
//                    print("失败\(resp)")
//                }
//            }
            KCFace.configSDK("kechong", "\(text)", "", "", "kc", "kechong")
            KCFace.payRecords(0, 0) { (bool, resp) in
                print("返回:\(resp ?? Dictionary())")
                if let r = resp{
                    let alert = UIAlertView(title: "消费记录", message: kcGetJSONStringFromDictionary(dictionary: resp), delegate: nil, cancelButtonTitle: "确定")
                    alert.show()
                }else{
                    let alert = UIAlertView(title: "", message: "", delegate: nil, cancelButtonTitle: "确定")
                    alert.show()
                }
            }
        }else{
            let alert = UIAlertView(title: "提示", message: "请输入用户cus", delegate: nil, cancelButtonTitle: "确定")
            alert.show()
        }
        
        
    }
    //唤起sdk
    @objc func btnAction(sender: UIButton){
        if let text = self.textView.text {
            UserDefaults.standard.set(text, forKey: "_cus")
            UserDefaults.standard.synchronize()
//            KCSDKManager.sharedInstances.updateContractId("contractId") { (bool) in
//                if bool == true {
//                    print("修改成功!")
//                }else{
//                    print("修改失败")
//                }
//            }
            KCFace.configSDK("kechong", "\(text)", "", "", "kc", "kechong")
            KCFace.delegate = self
            KCFace.showKCFace(self) { (bool, desc) in
                if bool == true {
                    print("sdk唤起成功!")
                }else{
                    print("SDK唤起失败\(desc)")
                }
            }
        }else{
            let alert = UIAlertView(title: "提示", message: "请输入用户cus", delegate: nil, cancelButtonTitle: "确定")
            alert.show()
        }
        
    }
    //唤起sdk
    @objc func btnAction3(sender: UIButton){
        if let text = self.textView.text {
            UserDefaults.standard.set(text, forKey: "_cus")
            UserDefaults.standard.synchronize()
            
            let contractId = "xxxxxxxx"
            KCFace.configSDK("kechong", "\(text)", "", "", "kc", "kechong")
            KCFace.delegate = self
            KCFace.updateContractId(contractId, complete: { (bool) in
                var title = "修改成功"
                if bool == true {
                    print("修改成功")
                }else{
                    print("修改失败")
                    title = "修改失败"
                }
                let alert = UIAlertView(title: "微信免密签名", message: title, delegate: nil, cancelButtonTitle: "确定")
                alert.show()
            })
        }else{
            let alert = UIAlertView(title: "提示", message: "请输入用户cus", delegate: nil, cancelButtonTitle: "确定")
            alert.show()
        }
        
    }
    //KCSDKDelegate
    func kcAccreditWXPay()  {
        print("去k开通~~~")
    }
}

///字典转json
func kcGetJSONStringFromDictionary(dictionary:[String :Any]?) -> String {
    if (!JSONSerialization.isValidJSONObject(dictionary!)) {
        print("无法解析出JSONString")
        return ""
    }
    let data : Data! = try? JSONSerialization.data(withJSONObject: dictionary!, options: []) as Data?
    let JSONString = String(data:data as Data,encoding: String.Encoding.utf8)
    return JSONString! as String
    
}
