//
//  ComposeViewController.h
//  twitter
//
//  Created by Paula Leticia Geronimo on 7/1/21.
//  Copyright © 2021 Emerson Malca. All rights reserved.
//
#import "Tweet.h"
#import "APIManager.h"

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ComposeViewControllerDelegate
- (void)didTweet:(Tweet *)tweet;
- (IBAction)postTweet:(id)sender;
@end

@interface ComposeViewController : UIViewController
@property (nonatomic, weak) id<ComposeViewControllerDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
