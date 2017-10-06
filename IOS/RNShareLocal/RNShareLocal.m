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

RCT_EXPORT_METHOD(message:(NSString *)title picUrl:(NSString *)picUrl excluded:(NSArray *)excluded callback:(RCTResponseSenderBlock)callback)
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
    
    NSMutableArray *excludedArray = [NSMutableArray arrayWithCapacity:15];
    if ([excluded containsObject:@"UIActivityTypeMessage"]) {
        [excludedArray addObject:UIActivityTypeMessage];
    }
    if ([excluded containsObject:@"UIActivityTypePostToFacebook"]) {
        [excludedArray addObject:UIActivityTypePostToFacebook];
    }
    if ([excluded containsObject:@"UIActivityTypePostToTwitter"]) {
        [excludedArray addObject:UIActivityTypePostToTwitter];
    }
    if ([excluded containsObject:@"UIActivityTypePostToWeibo"]) {
        [excludedArray addObject:UIActivityTypePostToWeibo];
    }
    if ([excluded containsObject:@"UIActivityTypeMail"]) {
        [excludedArray addObject:UIActivityTypeMail];
    }
    if ([excluded containsObject:@"UIActivityTypePrint"]) {
        [excludedArray addObject:UIActivityTypePrint];
    }
    if ([excluded containsObject:@"UIActivityTypeCopyToPasteboard"]) {
        [excludedArray addObject:UIActivityTypeCopyToPasteboard];
    }
    if ([excluded containsObject:@"UIActivityTypeAssignToContact"]) {
        [excludedArray addObject:UIActivityTypeAssignToContact];
    }
    if ([excluded containsObject:@"UIActivityTypeSaveToCameraRoll"]) {
        [excludedArray addObject:UIActivityTypeSaveToCameraRoll];
    }
    if ([excluded containsObject:@"UIActivityTypeAddToReadingList"]) {
        [excludedArray addObject:UIActivityTypeAddToReadingList];
    }
    if ([excluded containsObject:@"UIActivityTypePostToFlickr"]) {
        [excludedArray addObject:UIActivityTypePostToFlickr];
    }
    if ([excluded containsObject:@"UIActivityTypePostToVimeo"]) {
        [excludedArray addObject:UIActivityTypePostToVimeo];
    }
    if ([excluded containsObject:@"UIActivityTypePostToTencentWeibo"]) {
        [excludedArray addObject:UIActivityTypePostToTencentWeibo];
    }
    if ([excluded containsObject:@"UIActivityTypeAirDrop"]) {
        [excludedArray addObject:UIActivityTypeAirDrop];
    }
    if ([excluded containsObject:@"UIActivityTypeOpenInIBooks"]) {
        [excludedArray addObject:UIActivityTypeOpenInIBooks];
    }
    
    
    //NSLog(@"%@", excludedArray);
    activityVC.excludedActivityTypes = excludedArray;
    
    activityVC.completionWithItemsHandler = ^(NSString *activityType, BOOL completed, NSArray *returnedItems, NSError *activityError) {
        if (completed){
            //NSLog(@"The Activity: %@ was completed", activityType);
            callback(@[activityType]);
        }else{
            //NSLog(@"The Activity: %@ was NOT completed", activityType);
            callback(@[@"fail"]);
        }
        
    };
}

//分享连接
RCT_EXPORT_METHOD(link:(NSString *)title url:(NSString *)url picUrl:(NSString *)picUrl excluded:(NSArray *)excluded callback:(RCTResponseSenderBlock)callback)
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
    
    NSMutableArray *excludedArray = [NSMutableArray arrayWithCapacity:15];
    if ([excluded containsObject:@"UIActivityTypeMessage"]) {
        [excludedArray addObject:UIActivityTypeMessage];
    }
    if ([excluded containsObject:@"UIActivityTypePostToFacebook"]) {
        [excludedArray addObject:UIActivityTypePostToFacebook];
    }
    if ([excluded containsObject:@"UIActivityTypePostToTwitter"]) {
        [excludedArray addObject:UIActivityTypePostToTwitter];
    }
    if ([excluded containsObject:@"UIActivityTypePostToWeibo"]) {
        [excludedArray addObject:UIActivityTypePostToWeibo];
    }
    if ([excluded containsObject:@"UIActivityTypeMail"]) {
        [excludedArray addObject:UIActivityTypeMail];
    }
    if ([excluded containsObject:@"UIActivityTypePrint"]) {
        [excludedArray addObject:UIActivityTypePrint];
    }
    if ([excluded containsObject:@"UIActivityTypeCopyToPasteboard"]) {
        [excludedArray addObject:UIActivityTypeCopyToPasteboard];
    }
    if ([excluded containsObject:@"UIActivityTypeAssignToContact"]) {
        [excludedArray addObject:UIActivityTypeAssignToContact];
    }
    if ([excluded containsObject:@"UIActivityTypeSaveToCameraRoll"]) {
        [excludedArray addObject:UIActivityTypeSaveToCameraRoll];
    }
    if ([excluded containsObject:@"UIActivityTypeAddToReadingList"]) {
        [excludedArray addObject:UIActivityTypeAddToReadingList];
    }
    if ([excluded containsObject:@"UIActivityTypePostToFlickr"]) {
        [excludedArray addObject:UIActivityTypePostToFlickr];
    }
    if ([excluded containsObject:@"UIActivityTypePostToVimeo"]) {
        [excludedArray addObject:UIActivityTypePostToVimeo];
    }
    if ([excluded containsObject:@"UIActivityTypePostToTencentWeibo"]) {
        [excludedArray addObject:UIActivityTypePostToTencentWeibo];
    }
    if ([excluded containsObject:@"UIActivityTypeAirDrop"]) {
        [excludedArray addObject:UIActivityTypeAirDrop];
    }
    if ([excluded containsObject:@"UIActivityTypeOpenInIBooks"]) {
        [excludedArray addObject:UIActivityTypeOpenInIBooks];
    }
    
    
    //NSLog(@"%@", excludedArray);
    activityVC.excludedActivityTypes = excludedArray;
    
    activityVC.completionWithItemsHandler = ^(NSString *activityType, BOOL completed, NSArray *returnedItems, NSError *activityError) {
        if (completed){
            //NSLog(@"The Activity: %@ was completed", activityType);
            callback(@[activityType]);
        }else{
            //NSLog(@"The Activity: %@ was NOT completed", activityType);
            callback(@[@"fail"]);
        }
        
    };
}

//分享多图，最多九张
RCT_EXPORT_METHOD(pictures:(NSArray *)ImagesUrl excluded:(NSArray *)excluded callback:(RCTResponseSenderBlock)callback)
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

    NSMutableArray *excludedArray = [NSMutableArray arrayWithCapacity:15];
    if ([excluded containsObject:@"UIActivityTypeMessage"]) {
        [excludedArray addObject:UIActivityTypeMessage];
    }
    if ([excluded containsObject:@"UIActivityTypePostToFacebook"]) {
        [excludedArray addObject:UIActivityTypePostToFacebook];
    }
    if ([excluded containsObject:@"UIActivityTypePostToTwitter"]) {
        [excludedArray addObject:UIActivityTypePostToTwitter];
    }
    if ([excluded containsObject:@"UIActivityTypePostToWeibo"]) {
        [excludedArray addObject:UIActivityTypePostToWeibo];
    }
    if ([excluded containsObject:@"UIActivityTypeMail"]) {
        [excludedArray addObject:UIActivityTypeMail];
    }
    if ([excluded containsObject:@"UIActivityTypePrint"]) {
        [excludedArray addObject:UIActivityTypePrint];
    }
    if ([excluded containsObject:@"UIActivityTypeCopyToPasteboard"]) {
        [excludedArray addObject:UIActivityTypeCopyToPasteboard];
    }
    if ([excluded containsObject:@"UIActivityTypeAssignToContact"]) {
        [excludedArray addObject:UIActivityTypeAssignToContact];
    }
    if ([excluded containsObject:@"UIActivityTypeSaveToCameraRoll"]) {
        [excludedArray addObject:UIActivityTypeSaveToCameraRoll];
    }
    if ([excluded containsObject:@"UIActivityTypeAddToReadingList"]) {
        [excludedArray addObject:UIActivityTypeAddToReadingList];
    }
    if ([excluded containsObject:@"UIActivityTypePostToFlickr"]) {
        [excludedArray addObject:UIActivityTypePostToFlickr];
    }
    if ([excluded containsObject:@"UIActivityTypePostToVimeo"]) {
        [excludedArray addObject:UIActivityTypePostToVimeo];
    }
    if ([excluded containsObject:@"UIActivityTypePostToTencentWeibo"]) {
        [excludedArray addObject:UIActivityTypePostToTencentWeibo];
    }
    if ([excluded containsObject:@"UIActivityTypeAirDrop"]) {
        [excludedArray addObject:UIActivityTypeAirDrop];
    }
    if ([excluded containsObject:@"UIActivityTypeOpenInIBooks"]) {
        [excludedArray addObject:UIActivityTypeOpenInIBooks];
    }
    
    
    //NSLog(@"%@", excludedArray);
    activityVC.excludedActivityTypes = excludedArray;
    
    activityVC.completionWithItemsHandler = ^(NSString *activityType, BOOL completed, NSArray *returnedItems, NSError *activityError) {
        if (completed){
            //NSLog(@"The Activity: %@ was completed", activityType);
            callback(@[activityType]);
        }else{
            //NSLog(@"The Activity: %@ was NOT completed", activityType);
            callback(@[@"fail"]);
        }
        
    };
    
    [rootController presentViewController:activityVC animated:YES completion:nil];
}

@end
