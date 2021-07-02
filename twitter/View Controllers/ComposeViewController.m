//
//  ComposeViewController.m
//  twitter
//
//  Created by Paula Leticia Geronimo on 7/1/21.
//  Copyright © 2021 Emerson Malca. All rights reserved.
//

#import "ComposeViewController.h"
#import "APIManager.h"

@interface ComposeViewController () <UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *tweetText;
@property (weak, nonatomic) IBOutlet UILabel *charCount;

@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tweetText.text = @"What's happening?";
    self.tweetText.textColor = [UIColor lightGrayColor];
    self.charCount.text = @"280";
    // Do any additional setup after loading the view.
}
- (IBAction)postTweet:(id)sender {
    // first see if tweet is valid in terms of char length
    if ([self.tweetText.text length] > 280) { // invalid tweet
        NSLog(@"Tweet too long!");
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Cannot post tweet" message:@"Tweet is above the 280-character limit." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *dismissAction = [UIAlertAction actionWithTitle:@"Dismiss" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            // do nothing, dismiss alert
        }];
        [alert addAction:dismissAction];
        [self presentViewController:alert animated:YES completion:^{}];
    } else { // valid tweet
        NSString *statusId = nil;
        
        [[APIManager shared] postStatusWithText:self.tweetText.text completion:^(Tweet *tweet, NSError *error) {
            if (error) {
                NSLog(@"Error posting tweet: %@", error.localizedDescription);
            } else {
                NSLog(@"Tweeted successfully!");
                [self.delegate didTweet:tweet];
                // dismiss modal
                [self dismissViewControllerAnimated:true completion:nil];
            }
        }];
    }
}

- (IBAction)onClose:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
