//
//  HQLoginViewController.h
//  KeychainDemo
//
//  Created by Qilin Hu on 2020/5/26.
//  Copyright © 2020 Shanghai Haidian Information Technology Co.Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 ## 登录页面
 
 ## 功能特性
 1. 猫头鹰登录动画；
 2. 通过 UUIDManager 模块生成 UUID 并保存到钥匙串；
 3. 通过 SAMKeychain 保存用户名和密码到钥匙串；
 
 ## 参考
 - [简书：iOS 编程：获取设备信息和应用跳转@独木舟的木](https://www.jianshu.com/p/40b9f8ec1c78)
 - [简书：iOS 如何获取设备的唯一标识（UUID）@若锦](https://www.jianshu.com/p/37899e767f5b)
 - [iOS 钥匙串 Keychain 安全机制](https://juejin.im/post/5bf2a942e51d4546db6bd139)
 - [iOS KeyChain 使用和封装，唯一标识符存储](https://www.jianshu.com/p/e92e4e4b41a5)
 - 【Objective-C】[soffes/SAMKeychain](https://github.com/soffes/SAMKeychain) ⭐️5.3k - 适用于 Mac 和 iOS 的钥匙串的简单 Objective-C 包装器
 - 【Swift】 [KeychainAccess](https://github.com/kishikawakatsumi/KeychainAccess) ⭐️5.5k - Simple Swift wrapper for Keychain that works on iOS, watchOS, tvOS and macOS.
 - [qixin1106/KeychainIDFA](https://github.com/qixin1106/KeychainIDFA) ⭐️130 - 获取 IDFA 标示当设备唯一识别，并保存到 keychain 中。基本不变。除非刷机.
 */
@interface HQLoginViewController : UIViewController

@end

NS_ASSUME_NONNULL_END
