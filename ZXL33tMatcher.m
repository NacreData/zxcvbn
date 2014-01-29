//
//  ZXL33tMatcher.m
//  
//
//  Created by Devin Ceartas on 1/23/14.
//
//

#import "ZXL33tMatcher.h"
#import "ZXMatcher.h"

@implementation ZXL33tMatcher

-(instancetype)init {
    self = [super init];
    self.l33t_table = @{
                        @"a": @[@"4", @"@"],
                        @"b": @[@"8"],
                        @"c": @[@"(", @"{", @"[", @"<"],
                        @"e": @[@"3"],
                        @"g": @[@"6", @"9"],
                        @"i": @[@"1", @"!", @"|"],
                        @"l": @[@"1", @"|", @"7"],
                        @"o": @[@"0"],
                        @"s": @[@"$", @"5"],
                        @"t": @[@"+", @"7"],
                        @"x": @[@"%"],
                        @"z": @[@"2"]
                        };
}


-(NSArray *)matchForPassword:(NSString *)password {
    NSMutableArray *result = [[NSMutableArray alloc] init];
    NSArray *l33t_subs = [self enumerate_l33t_subs:[self relevent_l33t_subtable:password]];
    
    double _i, _len, _j, _len1, _k, _len2, i, j;
    
    for (_i = 0, _len = [l33t_subs count]; _i < _len; _i++) {
        sub = l33t_subs[_i];
        
        for (_j = 0, _len1 = [self.dictionary_matchers count]; _j < _len1; _j++) {
            ZXMatcher *matcher = self.dictionary_matchers[_j];
            NSString *subbed_password = [self translate:password with:sub];
            NSArray *_ref1 = [matcher matchForPassword:subbed_password];
            
            for (_k = 0, _len2 = [_ref1 count]; _k < _len2; _k++) {
                NSDictionary *match = _ref1[_k];
                i = [match objectForKey:@"i"];
                j = [match objectForKey:@"j"];
                int length = (j+1)-i;
                if ((length + i) > [password length]) {
                    length = [password length]-i;
                }
                NSString *token = [password substringWithRange:NSMakeRange(i,length)];
// STOPED HERE
                token = password.slice(match.i, +match.j + 1 || 9e9);

            }
        }
    }
}

// tested.
-(NSDictionary *)relevent_l33t_subtable:(NSString *)password {
    NSMutableDictionary *filtered = [self.l33t_table mutableCopy];
    NSArray *keys = [filtered allKeys];
    for( NSString *letter in keys ) {
        if ([password rangeOfString:letter].location == NSNotFound) {
            [filtered removeObjectForKey:letter];
        }
    }
    return [NSDictionary dictionaryWithDictionary:filtered];
}

// tested.
-(NSArray *)enumerate_l33t_subs:(NSDictionary *)table {
    NSMutableArray *result = [[NSMutableArray alloc] init];
    NSArray *keys = [table allKeys];
    double len = [keys count];
    if(0 == len) { return @[]; }
    
    for( NSString *symbol in [table objectForKey:keys[0]]) {
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithCapacity:len];
        [dict setObject:keys[0] forKey:symbol];
        [result addObject:dict];
    }
    
    for(int i=1; i<len; i++) {
        NSArray *r = [result copy];
        for( NSDictionary *dict in r ) {
            for( NSString *symbol in [table objectForKey:keys[i]]) {
                NSMutableDictionary *d = [dict mutableCopy];
                [d setObject:keys[i] forKey:symbol];
                [result addObject:d];
            }
            [result removeObject:dict];
        }
    }
    
    return [NSArray arrayWithArray:result];
}

// tested.
-(NSString *)translate:(NSString *)string with:(NSDictionary *)char_map {
    int stringLen = [string length];
    NSMutableString *result = [[NSMutableString alloc] initWithCapacity:stringLen];
    NSString *character = nil;
    for (int i=0; i < stringLen; i++) {
        NSString *ichar  = [NSString stringWithFormat:@"%c", [string characterAtIndex:i]];
        if( (character = [char_map objectForKey:ichar]) ) {
            [result appendString:character];
        }
        else {
            [result appendString:ichar];
        }
    }
    return result;
}


@end
