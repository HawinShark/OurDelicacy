//
//  List.h
//
//  Created by lanou  on 16/4/22
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface List : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *imageid;
@property (nonatomic, strong) NSString *authorname;
@property (nonatomic, strong) NSString *collectCount;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *listDescription;
@property (nonatomic, strong) NSString *likeCount;
@property (nonatomic, strong) NSString *listIdentifier;
@property (nonatomic, strong) NSString *authorid;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *authorimageid;
@property (nonatomic, strong) NSString *commentCount;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
