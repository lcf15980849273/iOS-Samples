//
//  ApplicationUpdateViewController.m
//  UIPresentationController
//
//  Created by Qilin Hu on 2020/7/2.
//  Copyright © 2020 Shanghai Haidian Information Technology Co.Ltd. All rights reserved.
//

#import "ApplicationUpdateViewController.h"

@interface ApplicationUpdateViewController ()

@end

@implementation ApplicationUpdateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self updatePreferredContentSizeWithTraitCollection:self.traitCollection];
}

//| ----------------------------------------------------------------------------
- (void)willTransitionToTraitCollection:(UITraitCollection *)newCollection withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    [super willTransitionToTraitCollection:newCollection withTransitionCoordinator:coordinator];
    
    // When the current trait collection changes (e.g. the device rotates),
    // update the preferredContentSize.
    [self updatePreferredContentSizeWithTraitCollection:newCollection];
}


//| ----------------------------------------------------------------------------
//! Updates the receiver's preferredContentSize based on the verticalSizeClass
//! of the provided \a traitCollection.
//
- (void)updatePreferredContentSizeWithTraitCollection:(UITraitCollection *)traitCollection
{
    // 左右留35
    // 上下留80
    
    CGFloat w = self.view.bounds.size.width - 35.f * 2;
    CGFloat h = self.view.bounds.size.height - 80.f * 2;
    
    self.preferredContentSize = CGSizeMake(w,h);
}

@end
