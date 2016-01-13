//
//  AppDelegate.m
//  iWork
//
//  Created by Adele on 11/12/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import "AppDelegate.h"

#import "WXApi.h"
#import "APService.h"
#import <SMS_SDK/SMSSDK.h>
#import <ShareSDK/ShareSDK.h>

#import "WGCommon.h"
#import "WGNotificationController.h"
#import "WGGlobal.h"
#import "UIDevice+WGIdentifier.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (void)initSDKWithLaunchOptions:(NSDictionary *)launchOptions{
    //极光
    // Required
    #if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_7_1
        if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
            //categories
            [APService
             registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                 UIUserNotificationTypeSound |
                                                 UIUserNotificationTypeAlert)
             categories:nil];
        } else {
            //categories nil
            [APService
             registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                 UIRemoteNotificationTypeSound |
                                                 UIRemoteNotificationTypeAlert)
#else
             //categories nil
             categories:nil];
            [APService
             registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                 UIRemoteNotificationTypeSound |
                                                 UIRemoteNotificationTypeAlert)
#endif
             // Required
             categories:nil];
        }
    [APService setupWithOption:launchOptions];    
    
      //ShareSDK
    [ShareSDK registerApp:kShareSDK_appKey];

    [ShareSDK connectWeChatWithAppId:kWeChat_appKey
                           appSecret:kWeChat_secret
                           wechatCls:[WXApi class]];
    [ShareSDK connectSinaWeiboWithAppKey:kSinaWeibo_appkey
                               appSecret:kSinaWeibo_secret
                             redirectUri:kSinaWeibo_url];
    
    
//    [ShareSDK registerApp:kShareSDK_appKey activePlatforms:@[@(SSDKPlatformTypeSinaWeibo),@(SSDKPlatformTypeTencentWeibo)] onImport:nil onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo) {
//        switch (platformType) {
//            case SSDKPlatformTypeSinaWeibo:
//                [appInfo SSDKSetupSinaWeiboByAppKey:kSinaWeibo_appkey appSecret:kSinaWeibo_secret redirectUri:kSinaWeibo_url authType:SSDKAuthTypeBoth];
//                break;
//                
//            default:
//                [appInfo SSDKSetupWeChatByAppId:kWeChat_appKey appSecret:kWeChat_secret];
//                break;	
//        }
//    }];
    
    //SMS_SDK
    [SMSSDK registerApp:kSMSSDK_appkey withSecret:kSMSSDK_secret];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self initSDKWithLaunchOptions:launchOptions];
    
    NSString *eqNum = [[UIDevice currentDevice] UniqueGlobalDeviceIdentifier];
    [[WGGlobal sharedInstance] saveDeviceToken:eqNum];

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    application.applicationIconBadgeNumber = 0;
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    // Required
    NSString *tokenStr = [deviceToken description];
    NSString *pushToken = [[[tokenStr
                             stringByReplacingOccurrencesOfString:@"<" withString:@""]
                            stringByReplacingOccurrencesOfString:@">" withString:@""]
                           stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    
    [APService registerDeviceToken:deviceToken];
}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    // Required
    [APService handleRemoteNotification:userInfo];
}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler{
    // IOS 7 Support Required
    [APService handleRemoteNotification:userInfo];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"GotoNotification" object:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    return [ShareSDK handleOpenURL:url wxDelegate:self];
}
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    return [ShareSDK handleOpenURL:url sourceApplication:sourceApplication annotation:annotation wxDelegate:self];
}

@end
