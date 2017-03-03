//
//  DMNMovieController.h
//  MovieSearch
//
//  Created by Josh "Sexy Abs" McDonald on 3/3/17.
//  Copyright © 2017 Open Reel Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIKit/UIKit.h"

@class DMNMovie;

NS_ASSUME_NONNULL_BEGIN

@interface DMNMovieController : NSObject

+ (void)fetchMoviesForSearchTerm:(NSString *)searchTerm completion:(void (^_Nullable) (NSArray *movies))completion;

+ (void)fetchPosterImage:(NSString *)imagePath completion:(void (^)(UIImage *))completion;


@end

NS_ASSUME_NONNULL_END
