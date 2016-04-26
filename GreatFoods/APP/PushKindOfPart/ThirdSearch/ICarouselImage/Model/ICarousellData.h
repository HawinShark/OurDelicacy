//
//  ICarousellData.h
//
//  Created by 浩文 夏 on 16/4/25
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ICarousellData : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double dataIdentifier;
@property (nonatomic, assign) double createDate;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, assign) id pageInfo;
@property (nonatomic, strong) NSString *path;
@property (nonatomic, assign) id endDate;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, assign) double modifyDate;
@property (nonatomic, assign) id beginDate;
@property (nonatomic, strong) NSString *linkType;
@property (nonatomic, strong) NSString *releasePlat;
@property (nonatomic, assign) id content;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
