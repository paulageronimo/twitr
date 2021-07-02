//
//  APIManager.h
//  twitter
//
//  Created by emersonmalca on 5/28/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "BDBOAuth1SessionManager.h"
#import "BDBOAuth1SessionManager+SFAuthenticationSession.h"
#import "Tweet.h"

@interface APIManager : BDBOAuth1SessionManager

+ (instancetype)shared;

- (void)getHomeTimelineWithNum:(NSInteger )tweetAmt completion:(void(^)(NSArray *tweets, NSError *error))completion;
// favorting a tweet
- (void)favorite:(Tweet *)tweet completion:(void (^)(Tweet *, NSError *))completion;
- (void)unfavorite:(Tweet *)tweet completion:(void (^)(Tweet *, NSError *))completion;
// retweeting
- (void)retweet:(Tweet *)tweet completion:(void(^)(Tweet *, NSError *))completion;
- (void)unretweet:(Tweet *)tweet completion:(void(^)(Tweet *, NSError *))completion;

-(void)postStatusWithText:(NSString *)tweetText completion:(void (^)(Tweet *, NSError *))completion;



@end
