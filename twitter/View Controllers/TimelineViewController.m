//
//  TimelineViewController.m
//  twitter
//
//  Created by emersonmalca on 5/28/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "TimelineViewController.h"
#import "APIManager.h"
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "TweetCell.h"
#import "Tweet.h"
#import "UIImageView+AFNetworking.h"

@interface TimelineViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *arrayOfTweets; // property, bc it is a thing... duh.... + type and name; getter and setter array
// nonatomic, strong, defines the getter and setter
@property (nonatomic, strong) UIRefreshControl *refreshControl; // established variable
//@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

@implementation TimelineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupView];
    
    [self loadTweets];
    
}

- (void) setupView {
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    // refresh control
    self.refreshControl = [[UIRefreshControl alloc] init];
    
    [self.refreshControl addTarget:self action:@selector(loadTweets) forControlEvents:UIControlEventValueChanged]; // under the hood, target action pair, calling a particular method
    [self.tableView insertSubview:self.refreshControl atIndex:0];
    [self.tableView addSubview:self.refreshControl];
    
}

- (IBAction)onLogout:(id)sender {
    
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    //  Logging out feature guide
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    appDelegate.window.rootViewController = loginViewController;
    
    [[APIManager shared] logout];
}

- (void) loadTweets { // like fetchMovies
    
    [[APIManager shared] getHomeTimelineWithCompletion:^(NSArray *tweets, NSError *error) {
        if (tweets) {
            NSLog(@"😎😎😎 Successfully loaded home timeline");
            self.arrayOfTweets = tweets;
            for (NSDictionary *dictionary in tweets) {
                NSString *text = dictionary[@"text"];
                NSLog(@"%@", text);
            }
        } else {
            NSLog(@"😫😫😫 Error getting home timeline: %@", error.localizedDescription);
        }
    }];

}

- (void)loggedOut {
    // TimelineViewController.m
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;

    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    appDelegate.window.rootViewController = loginViewController;
    [[APIManager shared] logout];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayOfTweets.count;
    
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    TweetCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"TweetCell" forIndexPath:indexPath];
        
    Tweet *tweet = self.arrayOfTweets[indexPath.row];
    // from TweetCell.h
    // UIImageView *profilePicture;UILabel *name;UILabel *username; UILabel *tweetDate;UILabel *tweetText;UILabel *favCount;UIButton *favButton;UILabel *replyCount;IBOutlet UIButton *replyButton;UILabel *retweetCount;UIButton *retweetButton; UIButton *messageButton;
    
    // from User.h
    //  NSString *name; NSString *screenName; NSString *profilePicture;

    
    cell.name.text = tweet.user.name;
    cell.username.text = [@"@" stringByAppendingString:tweet.user.screenName];
    cell.tweetDate.text = tweet.createdAtString;
    cell.tweetText.text = tweet.text;
    cell.retweetCount.text = [NSString stringWithFormat:@"%i", tweet.retweetCount];
    cell.favCount.text = [NSString stringWithFormat:@"%i", tweet.favoriteCount];
    
//    cell.favButton.selected = ;
//    cell.retweetButton.selected = ;
    

    NSString *URLString = tweet.user.profilePicture;
    NSString *imgURLString = [URLString stringByReplacingOccurrencesOfString:@"_normal" withString:@""];
    
    NSURL *pfpURL = [NSURL URLWithString:imgURLString]; // same as a string, but it checks to see if it is a valid URL
    
    cell.profilePicture.image = nil; // blanks cell before downloading new one
    [cell.profilePicture setImageWithURL:pfpURL];
    
    return cell;
}
//#pragma mark - Navigation

//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//// Get the new view controller using [segue destinationViewController].
//// Pass the selected object to the new view controller.
//    UITableViewCell *tappedCell = sender;
//    // "hey table view, I have this cell of yours. Can you tell me the index path? pls n ty"
//    NSIndexPath *indexPath = [self.tableView indexPathForCell:tappedCell];
//    NSDictionary *movie = self.arrayOfTweets[indexPath.row];
//
//    DetailsViewController *detailViewController = [segue destinationViewController];
//    detailViewController.tweets = tweets;
//}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */





@end
