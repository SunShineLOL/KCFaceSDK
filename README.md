




**环境:
iOS 9.0+ / Mac OS X 10.14+
Xcode 10.0+
Swift 5.0+**

## SDK导入

- #### 1.1 手动导入

**[KCFaceSDK](https://github.com/SunShineLOL/KCFaceSDK )Swift5.x**

**[KCFaceSDK](https://github.com/SunShineLOL/KCFaceSDK/tree/Swift4.x )Swift4.x**

**[完整文档](https://www.jianshu.com/p/b1806ccfd8bc)**

将KCFaceSDK/文件中的**KCFace.framework,KCFaceBundle.bundle,KCFace.swift**导入你的项目中

- #### 1.2 [推荐]pod方式导入
```
use_frameworks! #注意如果pod中没有请添加use_frameworks!,如果被注释请取消注释
pod 'KCFaceKit', '~> 1.0.0'#Swift4.x版本请使用1.0.0以下(不包含1.0.0版本)例:pod 'KCFaceKit'~>0.1.0'
```
- #### 1.3 info.plist文件中添加相机隐私权限及描述
```
Privacy - Camera Usage Description App需要您的同意,才能访问相机，以便于识别你的面部信息
```

## 使用
```
import KCFace
```



## 2 用法
- ### Swift调用
**[推荐]**pod导入后可直接使用(库名)KCFace.方法名
```
//配置SDK
KCFace.configSDK("kechong", "cus", "", "", "kc", "kechong")
///如果app需要SDK提示用户开通免密支付需设置代理对线并实现代理方法
KCFace.delegate = self
///启动SDK Ui
KCFace.showKCFace(self) { (bool, desc) in
    if bool == true {
        print("sdk唤起成功!")
    }else{
        print("SDK唤起失败\(desc)")
    }
}
```
```
///修改添加微信免密签名id
//在调用前请先确定 已经调用过configSDK()配置SDK参数
KCFace.updateContractId("contractId") { (bool) in
    if bool == true {
        print("修改成功!")
    }else{
        print("修改失败")
    }
}
```
```
/*获取平台消费记录*/
//在调用前请先确定 已经调用过configSDK()配置SDK参数 
KCFace.payRecords(0, 0) { (bool, resp) in
    if bool == true {
        //成功
        print("成功!\(resp)")
    }else{
        //
        print("失败\(resp)")
    }
}
```
#### 或 **KCSDKManager** 
```
//配置SDK参数
let manager = KCSDKManager.sharedInstances
///设置代理
KCFace.delegate = self
//启动SDK
manager.showKCFace(self) { (bool, desc) in
    if bool == true {
        print("sdk唤起成功!")
    }else{
        print("SDK唤起失败\(desc)")
    }
}
```
## OC
```
//配置SDK 并启动SDK
KCSDKManager *manager = [KCSDKManager sharedInstances];
manager.delegate = self;
[manager configSDK:@"kechong" :@"cus" :@"" :@"" :@"kc" :@"kechong"];
[manager showKCFace:self complete:^(BOOL isSuss, NSString * _Nonnull desc) {
    if (isSuss) {
        NSLog(@"成功:%@",desc);
    }else{
        NSLog(@"失败:%@",desc);
    }
}];
```
## Other

```
pod search KCFaceKit 搜索库提示错误/或者搜索不到
[!] Unable to find a pod with name, author, summary, or description matching `KCFaceKit`
```
```
在终端进行以下操作

pod setup

pod repo update

//更新repo完成后 还是搜索不到KCFaceKit在终端中执行 
rm ~/Library/Caches/CocoaPods/search_index.json

//再执行 search pod会重新创建本地pod库索引
pod search KCFaceKit

```
