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
class ViewController: UIViewController,KCSDKDelegate,UITextFieldDelegate {
    let textView : UITextField! = UITextField()
    let cus = "2d08d3c1b7c14468ab14bf8aca454070"
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //let textView = UITextField();
        textView.placeholder = "2d08d3c1b7c14468ab14bf8aca454070 + (1-5位cus(数字/字母))"
        textView.delegate = self
        textView.layer.borderColor = UIColor.gray.cgColor
        textView.layer.borderWidth = 0.5
        textView.layer.shadowRadius = 4
        textView.font = .systemFont(ofSize: 18)
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
        
        if let cus = UserDefaults.standard.value(forKey: "_cus") {
            self.textView.text = cus as? String ?? ""
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    @objc func btnAction2(sender: UIButton){
        if let text = self.textView.text {
            UserDefaults.standard.set(text, forKey: "_cus")
            UserDefaults.standard.synchronize()
            KCSDKManager.sharedInstances.configSDK("kechong", "\(cus)\(text)", "", "", "kc", "kechong")
            KCSDKManager.sharedInstances.payRecords(0, 0) { (bool, resp) in
                print("返回:\(resp ?? Dictionary())")
                let alert = UIAlertView(title: "消费记录", message: kcGetJSONStringFromDictionary(dictionary: resp), delegate: nil, cancelButtonTitle: "确定")
                alert.show()
            }
        }else{
            let alert = UIAlertView(title: "提示", message: "请输入自定义cus", delegate: nil, cancelButtonTitle: "确定")
            alert.show()
        }
        
        
    }
    @objc func btnAction(sender: UIButton){
        if let text = self.textView.text {
            UserDefaults.standard.set(text, forKey: "_cus")
            UserDefaults.standard.synchronize()
            KCSDKManager.sharedInstances.configSDK("kechong", "\(cus)\(text)", "", "", "kc", "kechong")
            KCSDKManager.sharedInstances.delegate = self
            KCSDKManager.sharedInstances.showKCFace(self) { (bool, desc) in
                if bool == true {
                    print("sdk唤起成功!")
                }else{
                    print("SDK唤起失败\(desc)")
                }
            }
        }else{
            let alert = UIAlertView(title: "提示", message: "请输入自定义cus", delegate: nil, cancelButtonTitle: "确定")
            alert.show()
        }
        
    }
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
