//
//  TweetCell.m
//  twitter
//
//  Created by Paula Leticia Geronimo on 6/29/21.
//  Copyright © 2021 Emerson Malca. All rights reserved.
//

#import "TweetCell.h"
#import "Tweet.h"
#import "APIManager.h"

@implementation TweetCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // [self refreshData];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    
}

//- (void)refreshData { //updates cell UI (not any internal tweet info, that should already be changed)
//    self.favCount.text = [NSString stringWithFormat:@"%i", self.tweet.favCount];
//    self.retweetCount.text = [NSString stringWithFormat:@"%i", self.tweetText.retweetCount];
//}

// buttons for fav

// buttons for retweet

@end
