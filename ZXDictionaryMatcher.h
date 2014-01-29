//
//  ZXDictionaryMatcher.h
//  
//
//  Created by Devin Ceartas on 1/23/14.
//
//

#import "ZXMatcher.h"

@interface ZXDictionaryMatcher : ZXMatcher
-(NSArray *)matchForPassword:(NSString *)password;
@property (strong,nonatomic) NSDictionary *ranked_dict;
@property (strong,nonatomic) NSString *dict_name;
@end
