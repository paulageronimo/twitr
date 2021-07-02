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
#import "UIImageView+AFNetworking.h"


@implementation TweetCell

- (void)awakeFromNib {
    [super awakeFromNib];
    //[self configButtons];
    //[self refreshData];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    
}

//- (void)refreshData {
//    self.favCount.text = [NSString stringWithFormat:@"%i", self.tweet.favCount];
//    self.retweetCount.text = [NSString stringWithFormat:@"%i", self.tweetText.retweetCount];
//}

// buttons for fav
- (IBAction)didTapFavorite:(id)sender {
    self.tweet.favoriteCount ++;
    self.tweet.favorited = true;
    
    if (self.tweet.favorited)
        [self unfavorite];
    else
        [self favorite];
        
    //[self refreshData];
}

- (void) unfavorite {
    self.tweet.favorited = false;
    self.favButton.selected = false;
    self.tweet.favoriteCount --;
    
    [[APIManager shared] unfavorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
        if(error)
            NSLog(@"Error unfavoriting tweet: %@", error.localizedDescription);
        else
            NSLog(@"Unfavorited tweet: %@", tweet.text);
        
    }];
}

-(void) favorite {
    self.tweet.favorited = true;
    self.favButton.selected = true;
    self.tweet.favoriteCount ++;
    
    [[APIManager shared] favorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
        if(error)
            NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
        else
            NSLog(@"Favorited tweet: %@", tweet.text);
    }];
}

     
     
- (IBAction)didTapRetweet:(id)sender {

    if (self.tweet.retweeted) {
        [self unretweet];
    } else {
        [self retweet];
    }
    //[self refreshData];
}

- (void) unretweet {
    self.tweet.retweeted = false;
    self.retweetButton.selected = false;
    self.tweet.retweetCount --;

    [[APIManager shared] unretweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
        if(error){ NSLog(@"Error unretweeting: %@", error.localizedDescription);}
        else { NSLog(@"Unretweeted: %@", tweet.text);}
    }];

}

-(void) retweet {
    // update locally
    self.tweet.retweeted = true;
    self.retweetButton.selected = true;
    self.tweet.retweetCount++;

    [[APIManager shared] retweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
        if(error){
            NSLog(@"Error retweeting: %@", error.localizedDescription);
        } else {
            NSLog(@"Retweeted: %@", tweet.text);
        }
    }];
}

 @end
