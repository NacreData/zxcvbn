//
//  ZXDictionaryMatcher.m
//  
//
//  Created by Devin Ceartas on 1/23/14.
//
//

#import "ZXDictionaryMatcher.h"

@implementation ZXDictionaryMatcher
-(NSArray *)matchForPassword:(NSString *)password {
    NSMutableArray *result = [[NSMutableArray alloc] init];
    double len = [password length];
    NSString *password_lower = [password lowercaseString];
    int i, j, _i, _j;
    for (i = _i = 0; 0 <= len ? _i < len : _i > len; i = 0 <= len ? ++_i : --_i) {
        for (j = _j = i; i <= len ? _j < len : _j > len; j = i <= len ? ++_j : --_j) {
            int length = (j+1)-i;
            if ((length + i) > len) {
                length = len-i;
            }
            NSString *subString = [password_lower substringWithRange:NSMakeRange(i,length)];
            NSNumber *rank = [self.ranked_dict objectForKey:subString];
            if (rank) {
                [result addObject:@{
                                    @"pattern" : @"dictionary",
                                    @"i" : [NSNumber numberWithInt:i],
                                    @"j" : [NSNumber numberWithInt:j],
                                    @"token" : [password substringWithRange:NSMakeRange(i,length)],
                                    @"matched_word" : subString,
                                    @"rank" : rank,
                                    @"dictionary_name" : self.dict_name
                                    }];
            }
        }
    }
    return [NSArray arrayWithArray:result];
}
@end
