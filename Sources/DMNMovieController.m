//
//  DMNMovieController.m
//  MovieSearch
//
//  Created by Josh "The Stud" McDonald on 3/3/17.
//  Copyright © 2017 Open Reel Software. All rights reserved.
//

#import "DMNMovieController.h"
#import "DMNMovie.h"
#import "MovieSearch-Swift.h"

static NSString * const baseURLString = @"https://api.themoviedb.org/3/search/movie?";

static NSString * const apiKey = @"10c5d941b27e6633f72956e078d00158";

@implementation DMNMovieController

+ (void)fetchMoviesForSearchTerm:(NSString *)searchTerm completion:(void (^_Nullable) (NSArray *movies))completion
{
    
    // Set URL and Parameters
    
    NSURL *baseURL = [NSURL URLWithString:baseURLString];
    
    NSMutableDictionary *urlParameters = [[NSMutableDictionary alloc] init];
    
    [urlParameters setValue:apiKey forKey:@"api_key"];
    [urlParameters setValue:searchTerm forKey:@"query"];

    [NetworkController performRequestFor:baseURL httpMethodString:@"GET" urlParameters:urlParameters body:nil completion:^(NSData * data, NSError * error) {
        if (error) {
            NSLog(@"Error getting movie for searchTerm: %@: %@", searchTerm, error);
            completion(nil);
            return;
        }
        
        // Convert data -> JSON -> Dictionary
        
        NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        
        if (!jsonDictionary || ![jsonDictionary isKindOfClass:[NSDictionary class]]) {
            NSLog(@"Error parsing json: %@", error);
            completion(nil);
            return;
        }
        
        // Get the results array from the JSONdictionary.
        
        NSArray *movieDictionaries = jsonDictionary[@"results"];
        
        // Create a placeholder array to hold all the movies you will initialize
        
        NSMutableArray *movies = [NSMutableArray new];
        
        // Loop through the array and initialize a movie for each dictionary.
        // Add them to the array of movies you made.
        
        for (NSDictionary *movie in movieDictionaries) {
            DMNMovie *newMovie = [[DMNMovie alloc]initWithDictionary:movie];
            [movies addObject:newMovie];
        }
        
        // Call completion with the placeholder array.
        
        completion(movies);
    }];
}

+(void)fetchPosterImage:(NSString *)imagePath completion:(void (^)(UIImage * _Nonnull))completion
{
    NSURL *baseImageURL = [NSURL URLWithString:@"http://image.tmdb.org/t/p/w500"];
    NSURL *posterEndpoint = [baseImageURL URLByAppendingPathComponent:imagePath];
    
    [[[NSURLSession sharedSession] dataTaskWithURL:posterEndpoint completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) { NSLog(@"Error: %@", error); completion(nil); }
        
        if (!data) { NSLog(@"Error: No data returned from data task"); completion(nil); }
        
        UIImage *posterImage = [[UIImage alloc] initWithData:data];
        
        completion(posterImage);
        
    }] resume];
    
}

@end
