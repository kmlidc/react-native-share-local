//
//  RNShare.m
//  demos
//
//  Created by 杨斌 on 2017/5/17.
//  Copyright © 2017年 Facebook. All rights reserved.
//

#import "RNShareLocal.h"
@import UIKit;

@implementation RNShareLocal

RCT_EXPORT_MODULE();

RCT_EXPORT_METHOD(message:(NSString *)title picUrl:(NSString *)picUrl callback:(RCTResponseSenderBlock)callback)
{
    //定义一个可变数组，最多不能超过2个值
    NSMutableArray * objectsToShare = [NSMutableArray arrayWithCapacity:2];
    if(picUrl){
        UIImage * imageToShare = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString: picUrl]]];
        [objectsToShare addObject:imageToShare];
    }
    if(title){
        [objectsToShare addObject:title];
    }
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:objectsToShare applicationActivities:nil];
    activityVC.excludedActivityTypes = @[UIActivityTypeAirDrop];
    
    UIViewController *rootController = UIApplication.sharedApplication.delegate.window.rootViewController;
    
    [rootController presentViewController:activityVC animated:YES completion:nil];
    callback(@[[NSNull null]]);
}

//分享连接
RCT_EXPORT_METHOD(link:(NSString *)title url:(NSString *)url picUrl:(NSString *)picUrl callback:(RCTResponseSenderBlock)callback)
{
    
    //定义一个可变数组，最多不能超过2个值
    NSMutableArray * objectsToShare = [NSMutableArray arrayWithCapacity:2];
    if(picUrl){
        UIImage * imageToShare = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString: picUrl]]];
        [objectsToShare addObject:imageToShare];
    }
    if(title){
        [objectsToShare addObject:title];
    }
    if(url){
        [objectsToShare addObject:[NSURL URLWithString:url]];
    }
    
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:objectsToShare applicationActivities:nil];
    
    UIViewController *rootController = UIApplication.sharedApplication.delegate.window.rootViewController;
    
    [rootController presentViewController:activityVC animated:YES completion:nil];
    callback(@[[NSNull null]]);
}

//分享多图，最多九张
RCT_EXPORT_METHOD(pictures:(NSArray *)ImagesUrl callback:(RCTResponseSenderBlock)callback)
{
    NSUInteger count = [ImagesUrl count];
    //定义一个可变数组来存放分享的图片，最多不能超过9个
    NSMutableArray * objectsToShare = [NSMutableArray arrayWithCapacity:9];
    for (int i = 0; i < count; i++) {
        NSString * imageUrl = [ImagesUrl objectAtIndex: i];
        UIImage * imageToShare = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString: imageUrl]]];
        [objectsToShare addObject:imageToShare];
        if(i == 8)break;
    }
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:objectsToShare applicationActivities:nil];
    
    UIViewController *rootController = UIApplication.sharedApplication.delegate.window.rootViewController;
    
    [rootController presentViewController:activityVC animated:YES completion:nil];
    callback(@[[NSNull null]]);
}

@end
