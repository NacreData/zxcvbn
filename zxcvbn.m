#import "zxcvbn.h"
#import "ZXMatcher.h"
#import "ZXDictionaryMatcher.h"

@implementation


#pragma mark - Needed? 

-(BOOL)empty:(NSDictionary *)dict {
    return (0 == [dict count]);
}

-(NSArray *)extend:(NSArray *)arr with:(NSDictionary *)dict {
    return [arr arrayByAddingObject:dict];
}

#pragma mark - internal utility functions


// tested.
-(NSArray *)omnimatchForPassword:(NSString *)password {
    NSMutableArray *matches = [NSMutableArray arrayWithCapacity:[self.matchers count]];
    for( ZXMatcher *matcher in self.matchers ) {
        [matches addObject:[matcher matchForPassword:password]];
    }
    [matches sortUsingComparator:^NSComparisonResult(NSDictionary *dict1, NSDictionary *dict2) {
        return ([[dict1 objectForKey:@"i"] intValue] - [[dict2 objectForKey:@"i"] intValue])
        || ([[dict1 objectForKey:@"j"] intValue] - [[dict2 objectForKey:@"j"] intValue]);
    }];
    return [NSArray arrayWithArray:matches];
}

// tested.
-(NSDictionary *)build_ranked_dict:(NSArray *)unranked_list {
    double i, _len, _i;
    i = 1;
    NSMutableDictionary *result = [NSMutableDictionary dictionaryWithCapacity:[unranked_list count]];
    for (_i = 0, _len = [unranked_list count]; _i < _len; _i++) {
        [result setObject:[NSNumber numberWithDouble:i] forKey:[unranked_list objectAtIndex:_i]];
        i++;
    }
    return [NSDictionary dictionaryWithDictionary:result];
}

// tested.
-(ZXDictionaryMatcher *)build_dict_matcher:(NSString *)dict_name fromDictionary:(NSDictionary *)ranked_dict {
    
    ZXDictionaryMatcher *dict_matcher = [[ZXDictionaryMatcher alloc] init];
    dict_matcher.dict_name = dict_name;
    dict_matcher.ranked_dict = ranked_dict;
    return dict_matcher;
}



@end