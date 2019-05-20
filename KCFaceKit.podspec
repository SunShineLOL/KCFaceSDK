Pod::Spec.new do |s|
s.name     = "KCFaceKit"
s.version  = "1.0.0"
s.license  = "MIT"
s.summary  = "上海可充FaceKit"
s.homepage = "https://github.com/SunShineLOL/CZNSDKTests"
s.author   = { "陈耍耍" => "443623074@qq.com" }
s.social_media_url = "http://www.setpay.cn"
s.source   = { :git => "https://github.com/SunShineLOL/KCFaceSDK.git", :tag => "#{s.version}" }
s.description = %{
可充FaseSDK,为用户提供人脸录入,微信免密支付(需用户自行接入微信免密相关业务)
}
s.vendored_frameworks = 'KCFaceSDK/*.framework'
s.resource  = 'KCFaceSDK/*.bundle'
s.source_files = 'KCFaceSDK/*.swift'

s.requires_arc = true
s.platform = :ios, '9.0'
s.swift_version = '5.0'
end
