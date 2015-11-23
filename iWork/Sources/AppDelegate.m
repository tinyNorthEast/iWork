//
//  AppDelegate.m
//  iWork
//
//  Created by Adele on 11/12/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import "AppDelegate.h"

#import "WGCommon.h"
#import "APService.h"
#import <ShareSDK/ShareSDK.h>

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
//    [ShareSDK registerApp:kShareSDK_appkey];
//    [ShareSDK connectSMS];
//    [ShareSDK connectWeChatWithAppId:kWeChat_appKey
//                           wechatCls:[WXApi class]];
//    [ShareSDK importWeChatClass:[WXApi class]];
//    
//    [ShareSDK connectWeChatSessionWithAppId: kWeChat_appKey wechatCls:[WXApi class]];
//    [[ShareSDK connectWeChatTimelineWithAppId:kWeChat_appKey wechatCls:[WXApi class]];
//    
//    [ShareSDK connectSinaWeiboWithAppKey:kSinaWeibo_appkey appSecret:kSinaWeibo_secret redirectUri:kSinaWeibo_url];
    
    [ShareSDK registerApp:kShareSDK_appKey activePlatforms:@[@(SSDKPlatformTypeSinaWeibo),@(SSDKPlatformTypeTencentWeibo)] onImport:nil onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo) {
        switch (platformType) {
            case SSDKPlatformTypeSinaWeibo:
                [appInfo SSDKSetupSinaWeiboByAppKey:kSinaWeibo_appkey appSecret:kSinaWeibo_secret redirectUri:kSinaWeibo_url authType:SSDKAuthTypeBoth];
                break;
                
            default:
                [appInfo SSDKSetupWeChatByAppId:kWeChat_appKey appSecret:kWeChat_secret];
                break;
        }
    }];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self initSDKWithLaunchOptions:launchOptions];

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
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    // Required
    [APService registerDeviceToken:deviceToken];
}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    // Required
    [APService handleRemoteNotification:userInfo];
}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler{
    // IOS 7 Support Required
    [APService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}

@end
