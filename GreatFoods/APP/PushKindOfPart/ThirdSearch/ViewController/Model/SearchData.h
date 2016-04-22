//
//  SearchData.h
//
//  Created by 浩文 夏 on 16/4/22
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface SearchData : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double clickCount;
@property (nonatomic, strong) NSString *detailsUrl;
@property (nonatomic, assign) id difficulty;
@property (nonatomic, assign) double dataIdentifier;
@property (nonatomic, assign) id imageUrlFlow;
@property (nonatomic, assign) id category;
@property (nonatomic, assign) id nivoRelId;
@property (nonatomic, assign) id lable;
@property (nonatomic, strong) NSString *categoryID;
@property (nonatomic, assign) id taste;
@property (nonatomic, assign) double deleteStatus;
@property (nonatomic, strong) NSArray *screList;
@property (nonatomic, strong) NSString *dataDescription;
@property (nonatomic, assign) id technology;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *releaseDate;
@property (nonatomic, assign) id peopleEat;
@property (nonatomic, assign) id loadContent;
@property (nonatomic, strong) NSString *screeningId;
@property (nonatomic, assign) id area;
@property (nonatomic, assign) id indexUrl;
@property (nonatomic, assign) id imageHeight;
@property (nonatomic, assign) id parentCategoryId;
@property (nonatomic, assign) id shareUrl;
@property (nonatomic, strong) NSString *maketime;
@property (nonatomic, assign) id pageInfo;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) double shareCount;
@property (nonatomic, assign) BOOL favorite;
@property (nonatomic, assign) id releasePlat;
@property (nonatomic, assign) double createDate;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, assign) double modifyDate;
@property (nonatomic, assign) id imageWidth;
@property (nonatomic, strong) NSString *imageUrl;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) id videoRelId;
@property (nonatomic, assign) id displayState;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
