//
//  HQLTableViewGroupedModel.m
//  HQLTakePhotoDemo
//
//  Created by Qilin Hu on 2018/4/2.
//  Copyright © 2018年 ToninTech. All rights reserved.
//

#import "HQLTableViewGroupedModel.h"

@implementation HQLTableViewModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
        @"image"  : @"image",
        @"title"  : @"title",
        @"detail" : @"detail",
        @"tag"    : @"tag"
    };
}

#pragma mark - <HQLTableViewCellConfigureDelegate>

- (NSString *)imageName {
    return _image;
}
- (NSString *)titleLabelText {
    return _title;
}
- (NSString *)detailLabelText {
    return _detail;
}

@end

@implementation HQLTableViewGroupedModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
        @"headerTitle" : @"headerTitle",
        @"cells"       : @"cells"
    };
}

// JSON Array <——> NSArray<HQLTableViewModel>
+ (NSValueTransformer *)cellsJSONTransformer {
    return [MTLJSONAdapter arrayTransformerWithModelClass:HQLTableViewModel.class];
}

@end
