//
//  KCFace.swift
//  KCFace
//
//  Created by czn on 2019/5/16.
//  Copyright © 2019 czn. All rights reserved.
//

import Foundation

/*
 *  app    string
 *  cus    string
 *  sub    string 子用户编码
 *  contractId    string 微信免密代扣协议id
 *  platform    string 平台代号
 *  project    string 项目代号
 */
public func configSDK(_ app: String,_ cus: String?, _ sub: String?, _ contractId: String?, _ platform:String, _ project:String){
    KCSDKManager.sharedInstances.configSDK(app, cus, sub, contractId, platform, project)
}

public var delegate: KCSDKDelegate?{
        get{
            return KCSDKManager.sharedInstances.delegate
        }
        set{
            KCSDKManager.sharedInstances.delegate = newValue
        }
}

/*
 *  @objc public func updateContractId(_ contractId : String?)
 *  异步更新微信免密代扣
 */
///更新微信免密代扣协议
public func updateContractId(_ contractId : String?, complete:@escaping(_ isSuccess: Bool)->()){
    KCSDKManager.sharedInstances.updateContractId(contractId, complete: complete)
}

/*
 *  启动SDK界面
 *  启动页面前必须先调用配置SDK方法传入参数
 *  @objc public func configSDK(_ app: String,_ cus: String?, _ sub: String?, _ contractId: String?, _ platform:String, _ project:String)
 *  block bool true:启动成功,false启动失败
 */
public func showKCFace(_ vc: UIViewController, complete:((_ bool: Bool, _ desc: String) -> Void)? = nil ) {
    KCSDKManager.sharedInstances.showKCFace(vc, complete: complete)
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
public func payRecords(_ pageSize: Int, _ pageIndex: Int, complete:((_ bool: Bool, _ res: [String : AnyObject]?) -> Void)? = nil ) {
    KCSDKManager.sharedInstances.payRecords(pageSize, pageIndex, complete: complete)
}
