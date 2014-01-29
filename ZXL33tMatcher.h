//
//  ZXL33tMatcher.h
//  
//
//  Created by Devin Ceartas on 1/23/14.
//
//

#import <Foundation/Foundation.h>

@interface ZXL33tMatcher : ZXMatcher
@property (strong,nonatomic) NSArray *dictionary_matchers;
@property (strong,nonatomic) NSDictionary *l33t_table;
-(NSArray *)matchForPassword:(NSString *)password;
@end
