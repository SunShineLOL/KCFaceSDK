


## 1 导入方式
#### 1.1 手动导入
**支持版本iOS 9.0 以上**

##### 将KCFaseSDK/文件中的KCFace.framework,KCFaceBundle.bundle,KCFace.swift 导入你的项目中
![导入framework.png](https://upload-images.jianshu.io/upload_images/4277317-384920b44da27001.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
在你需要使用SDK的地方导入
```
import KCFace
```
#### 1.2 [推荐]pod方式导入
```
use_frameworks! #注意如果pod中没有请添加use_frameworks!,如果被注释请取消注释
pod 'KCFaceKit', '~> 1.0.0'
```
#### 1.3 info.plist文件中添加相机隐私权限及描述
```
Privacy - Camera Usage Description App需要您的同意,才能访问相机，以便于识别你的面部信息
```

## 2 用法
- ### 2.1 Swift调用
- 2.1.1 **[推荐]**快速调用
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
#### 或使用 **KCSDKManager** 调用
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
- ## 2.2 oc调用
在项目中新建一个swift文件(名字随意)然后根据提示添加桥接文件(注意:创建的.swift文件不能删除)
![桥接.png](https://upload-images.jianshu.io/upload_images/4277317-f82f4345516e219a.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
```
/*
* KCFace_oc_demo-Swift.h 
* KCFace_oc_demo//替换成你的项目名称
* projectName-Swift.h
*/
#import <KCFace_oc_demo-Swift.h>
```
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
## 3.Other

```
pod search KCFaceKit 搜索库提示错误/或者搜索不到
[!] Unable to find a pod with name, author, summary, or description matching `KCFaceKit`
```
```
在终端进行以下操作

pod setup

pod repo update

//执行完成后 还是搜索不到KCFaceKit在终端中执行 
rm ~/Library/Caches/CocoaPods/search_index.json

//再执行 search pod会重新创建本地pod库索引
pod search KCFaceKit

```
### KCFace.framwrok包含真机和模拟器环境在发布时需要去除i386/x86_64 
- **添加自动去除模拟器平台脚本**
选中项目->TARGETS(项目)->Build Phases
![创建脚本.png](https://upload-images.jianshu.io/upload_images/4277317-354548527303e744.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
#### 复制一下脚本代码到script中即可
```
 APP_PATH="${TARGET_BUILD_DIR}/${WRAPPER_NAME}"
 
  # This script loops through the frameworks embedded in the application and
  # removes unused architectures.
  find "$APP_PATH" -name '*.framework' -type d | while read -r FRAMEWORK
  do
  FRAMEWORK_EXECUTABLE_NAME=$(defaults read    "$FRAMEWORK/Info.plist" CFBundleExecutable)
  FRAMEWORK_EXECUTABLE_PATH="$FRAMEWORK/$FRAMEWORK_EXECUTAB LE_NAME"
  echo "Executable is $FRAMEWORK_EXECUTABLE_PATH"
 
  EXTRACTED_ARCHS=()
 
  for ARCH in $ARCHS
  do
  echo "Extracting $ARCH from $FRAMEWORK_EXECUTABLE_NAME"
  lipo -extract "$ARCH" "$FRAMEWORK_EXECUTABLE_PATH" -o       "$FRAMEWORK_EXECUTABLE_PATH-$ARCH"
  EXTRACTED_ARCHS+=("$FRAMEWORK_EXECUTABLE_PATH-$ARCH")
 done
 
  echo "Merging extracted architectures: ${ARCHS}"
  lipo -o "$FRAMEWORK_EXECUTABLE_PATH-merged" -create   "${EXTRACTED_ARCHS[@]}"
  rm "${EXTRACTED_ARCHS[@]}"
 
  echo "Replacing original executable with thinned version"
  rm "$FRAMEWORK_EXECUTABLE_PATH"
  mv "$FRAMEWORK_EXECUTABLE_PATH-merged"    "$FRAMEWORK_EXECUTABLE_PATH"
 
  done
```
![添加脚本.png](https://upload-images.jianshu.io/upload_images/4277317-4fc64a226b83ba7d.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
