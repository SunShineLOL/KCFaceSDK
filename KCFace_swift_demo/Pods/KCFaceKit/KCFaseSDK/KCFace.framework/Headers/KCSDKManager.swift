//
//  KCSDKManager.swift
//  KCFace
//
//  Created by czn on 2019/4/29.
//  Copyright © 2019 czn. All rights reserved.
//  1.0.5

import Foundation

@objc public protocol KCSDKDelegate: NSObjectProtocol {
    ///由客户端实现微信免密相关逻辑
    @objc optional func kcAccreditWXPay()
}

private let KCSDKManagerShareInstance = KCSDKManager()

public class KCSDKManager: NSObject{
    private var app: String?
    private var cus: String?
    private var sub: String?
    private var contractId: String?
    private var platform: String?
    private var project: String?
    @objc public weak var delegate: KCSDKDelegate?
    
   @objc public class var sharedInstances : KCSDKManager {
        return KCSDKManagerShareInstance
    }
    
    /*
     *  app    string
     *  cus    string
     *  sub    string 子用户编码
     *  contractId    string 微信免密代扣协议id
     *  platform    string 平台代号
     *  project    string 项目代号
     */
    @objc public func configSDK(_ app: String,_ cus: String?, _ sub: String?, _ contractId: String?, _ platform:String, _ project:String){
        self.app = app
        self.cus = cus ?? ""
        self.sub = sub ?? ""
        self.contractId = contractId ?? ""
        self.platform = platform
        self.project = project
    }
    
    ///获取传入SDK的参数
    @objc func getSDKInfo() -> [String : Any] {
        return ["cus_":["cus":cus,"app":app,"sub":sub,"contractId":contractId],
                "business_":["project":project,"platform":platform]]
    }
    
    /*
     *  @objc public func updateContractId(_ contractId : String?)
     *  异步更新微信免密代扣
     */
    ///更新微信免密代扣协议
    @objc public func updateContractId(_ contractId : String?, complete:@escaping(_ isSuccess: Bool)->()){
        if let cID = contractId {
            self.contractId = cID
            KCApis.init().contractUpdate(cID, paramer:KCSDKManager.sharedInstances.getSDKInfo() , complete: complete)
        }
    }
    
    /*
     *  启动SDK界面
     *  启动页面前必须先调用配置SDK方法传入参数
     *  @objc public func configSDK(_ app: String,_ cus: String?, _ sub: String?, _ contractId: String?, _ platform:String, _ project:String)
     *  block bool true:启动成功,false启动失败
     */
    @objc public func showKCFace(_ vc: UIViewController, complete:((_ bool: Bool, _ desc: String) -> Void)? = nil ) {
        UIApplication.shared.keyWindow?.chrysan.show()
        KCApis.init()
            .checkUserInfo(paramer: KCSDKManager.sharedInstances.getSDKInfo(), complete: { (user, bool, desc) -> (Void) in
                UIApplication.shared.keyWindow?.chrysan.hide()
                var d = "SDK启动成功:\(desc ?? "")"
                var type = 1
                if bool == true {
                    if let u = user {
                        //获取到用户数据跳转到管理页面
                        let kcvc = KCManageFaceViewController(user: u)
                        let kcnavvc = KCNavigationViewController(rootViewController: kcvc)
                        vc.present(kcnavvc, animated: true, completion: nil)//.pushViewController(kcnavvc, animated: true)
                        
                    }else{
                        if let de = desc {
                            UIApplication.shared.keyWindow?.chrysan.showMessage(de, hideDelay: 1.5)
                        }
                        //未获取到用户数据跳转到记录页面
                        let kcvc = KCFaceViewController(isCheck: false)
                        let kcnavvc = KCNavigationViewController(rootViewController: kcvc)
                        vc.present(kcnavvc, animated: true, completion: nil)
                    }
                    //启动错误收集
                    kcCommitCrashCapture()
                }else{
                    d = "启动失败:\(desc ?? "")"
                    type = 1
                }
                //启动回调
                if let c = complete{
                    c(bool,desc ?? "")
                }
                let p = kcGetJSONStringFromDictionary(dictionary: ["openCount":1,"desc":d])
                KCApis.init().sdkMinitor(p, type)
        })
        
       
    }
    
    /*
     *  查询用户平台消费记录
     *  ***参数***
     *  pageSize 1
     *  pageIndex 10
     *
     *  ***返回***
     *  "pageIndex": 1,
     *  "pageSize": 10,
     *  "totalCount": 0,
     *  "pageCount": 0,
     *      "data": {
     *          "orderId": "string",
     *          "amount": 0,
     *          "transactionTime": "string",
     *          "busNo": "string",
     *          "lineNo": "string",
     *          "picPath": "string"
     *      }
     *  ***END***
     */
    @objc public func payRecords(_ pageSize: Int, _ pageIndex: Int, complete:((_ bool: Bool, _ res: [String : AnyObject]?) -> Void)? = nil ) {
        var p = KCSDKManager.sharedInstances.getSDKInfo()
        p.updateValue(pageSize, forKey: "pageSize")
        p.updateValue(pageIndex, forKey: "pageIndex")
        KCApis.init()
            .payRecords(paramer: p, complete: { (resp, bool, desc) -> (Void) in
                //启动回调
                if let c = complete{
                    c(bool,resp)
                }
            })
    }
}
