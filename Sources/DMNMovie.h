//
//  DMNMovie.h
//  MovieSearch
//
//  Created by Josh "The Hunk" McDonald on 3/3/17.
//  Copyright © 2017 Open Reel Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIKit/UIKit.h"

@interface DMNMovie : NSObject

@property (nonatomic, copy, readonly) NSString *title;
@property (nonatomic, readonly) double rating;
@property (nonatomic, copy, readonly) NSString *overview;
@property (nonatomic) NSString *posterImage;

-(instancetype)initWithTitle:(NSString *)title rating:(double)rating overview:(NSString *)overview posterImage:(NSString *)posterImage; NS_DESIGNATED_INITIALIZER;


@end

@interface DMNMovie (JSONCovertable)

- (instancetype)initWithDictionary:(NSDictionary<NSString *, id> *)dictionary;

@end
