//
//  User.h
//  twitter
//
//  Created by Paula Leticia Geronimo on 6/29/21.
//  Copyright © 2021 Emerson Malca. All rights reserved.
//

// User.h
#import <Foundation/Foundation.h>
@interface User : NSObject

// TODO: Add properties
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *screenName;
@property (nonatomic, strong) NSString *profilePicture;


// TODO: Create initializer
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;


@end
