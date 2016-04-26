//
//  ICarousellData.m
//
//  Created by 浩文 夏 on 16/4/25
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "ICarousellData.h"


NSString *const kICarousellDataId = @"id";
NSString *const kICarousellDataCreateDate = @"createDate";
NSString *const kICarousellDataUrl = @"url";
NSString *const kICarousellDataPageInfo = @"pageInfo";
NSString *const kICarousellDataPath = @"path";
NSString *const kICarousellDataEndDate = @"endDate";
NSString *const kICarousellDataTitle = @"title";
NSString *const kICarousellDataType = @"type";
NSString *const kICarousellDataModifyDate = @"modifyDate";
NSString *const kICarousellDataBeginDate = @"beginDate";
NSString *const kICarousellDataLinkType = @"linkType";
NSString *const kICarousellDataReleasePlat = @"releasePlat";
NSString *const kICarousellDataContent = @"content";


@interface ICarousellData ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ICarousellData

@synthesize dataIdentifier = _dataIdentifier;
@synthesize createDate = _createDate;
@synthesize url = _url;
@synthesize pageInfo = _pageInfo;
@synthesize path = _path;
@synthesize endDate = _endDate;
@synthesize title = _title;
@synthesize type = _type;
@synthesize modifyDate = _modifyDate;
@synthesize beginDate = _beginDate;
@synthesize linkType = _linkType;
@synthesize releasePlat = _releasePlat;
@synthesize content = _content;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.dataIdentifier = [[self objectOrNilForKey:kICarousellDataId fromDictionary:dict] doubleValue];
            self.createDate = [[self objectOrNilForKey:kICarousellDataCreateDate fromDictionary:dict] doubleValue];
            self.url = [self objectOrNilForKey:kICarousellDataUrl fromDictionary:dict];
            self.pageInfo = [self objectOrNilForKey:kICarousellDataPageInfo fromDictionary:dict];
            self.path = [self objectOrNilForKey:kICarousellDataPath fromDictionary:dict];
            self.endDate = [self objectOrNilForKey:kICarousellDataEndDate fromDictionary:dict];
            self.title = [self objectOrNilForKey:kICarousellDataTitle fromDictionary:dict];
            self.type = [self objectOrNilForKey:kICarousellDataType fromDictionary:dict];
            self.modifyDate = [[self objectOrNilForKey:kICarousellDataModifyDate fromDictionary:dict] doubleValue];
            self.beginDate = [self objectOrNilForKey:kICarousellDataBeginDate fromDictionary:dict];
            self.linkType = [self objectOrNilForKey:kICarousellDataLinkType fromDictionary:dict];
            self.releasePlat = [self objectOrNilForKey:kICarousellDataReleasePlat fromDictionary:dict];
            self.content = [self objectOrNilForKey:kICarousellDataContent fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.dataIdentifier] forKey:kICarousellDataId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.createDate] forKey:kICarousellDataCreateDate];
    [mutableDict setValue:self.url forKey:kICarousellDataUrl];
    [mutableDict setValue:self.pageInfo forKey:kICarousellDataPageInfo];
    [mutableDict setValue:self.path forKey:kICarousellDataPath];
    [mutableDict setValue:self.endDate forKey:kICarousellDataEndDate];
    [mutableDict setValue:self.title forKey:kICarousellDataTitle];
    [mutableDict setValue:self.type forKey:kICarousellDataType];
    [mutableDict setValue:[NSNumber numberWithDouble:self.modifyDate] forKey:kICarousellDataModifyDate];
    [mutableDict setValue:self.beginDate forKey:kICarousellDataBeginDate];
    [mutableDict setValue:self.linkType forKey:kICarousellDataLinkType];
    [mutableDict setValue:self.releasePlat forKey:kICarousellDataReleasePlat];
    [mutableDict setValue:self.content forKey:kICarousellDataContent];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description 
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

    self.dataIdentifier = [aDecoder decodeDoubleForKey:kICarousellDataId];
    self.createDate = [aDecoder decodeDoubleForKey:kICarousellDataCreateDate];
    self.url = [aDecoder decodeObjectForKey:kICarousellDataUrl];
    self.pageInfo = [aDecoder decodeObjectForKey:kICarousellDataPageInfo];
    self.path = [aDecoder decodeObjectForKey:kICarousellDataPath];
    self.endDate = [aDecoder decodeObjectForKey:kICarousellDataEndDate];
    self.title = [aDecoder decodeObjectForKey:kICarousellDataTitle];
    self.type = [aDecoder decodeObjectForKey:kICarousellDataType];
    self.modifyDate = [aDecoder decodeDoubleForKey:kICarousellDataModifyDate];
    self.beginDate = [aDecoder decodeObjectForKey:kICarousellDataBeginDate];
    self.linkType = [aDecoder decodeObjectForKey:kICarousellDataLinkType];
    self.releasePlat = [aDecoder decodeObjectForKey:kICarousellDataReleasePlat];
    self.content = [aDecoder decodeObjectForKey:kICarousellDataContent];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_dataIdentifier forKey:kICarousellDataId];
    [aCoder encodeDouble:_createDate forKey:kICarousellDataCreateDate];
    [aCoder encodeObject:_url forKey:kICarousellDataUrl];
    [aCoder encodeObject:_pageInfo forKey:kICarousellDataPageInfo];
    [aCoder encodeObject:_path forKey:kICarousellDataPath];
    [aCoder encodeObject:_endDate forKey:kICarousellDataEndDate];
    [aCoder encodeObject:_title forKey:kICarousellDataTitle];
    [aCoder encodeObject:_type forKey:kICarousellDataType];
    [aCoder encodeDouble:_modifyDate forKey:kICarousellDataModifyDate];
    [aCoder encodeObject:_beginDate forKey:kICarousellDataBeginDate];
    [aCoder encodeObject:_linkType forKey:kICarousellDataLinkType];
    [aCoder encodeObject:_releasePlat forKey:kICarousellDataReleasePlat];
    [aCoder encodeObject:_content forKey:kICarousellDataContent];
}

- (id)copyWithZone:(NSZone *)zone
{
    ICarousellData *copy = [[ICarousellData alloc] init];
    
    if (copy) {

        copy.dataIdentifier = self.dataIdentifier;
        copy.createDate = self.createDate;
        copy.url = [self.url copyWithZone:zone];
        copy.pageInfo = [self.pageInfo copyWithZone:zone];
        copy.path = [self.path copyWithZone:zone];
        copy.endDate = [self.endDate copyWithZone:zone];
        copy.title = [self.title copyWithZone:zone];
        copy.type = [self.type copyWithZone:zone];
        copy.modifyDate = self.modifyDate;
        copy.beginDate = [self.beginDate copyWithZone:zone];
        copy.linkType = [self.linkType copyWithZone:zone];
        copy.releasePlat = [self.releasePlat copyWithZone:zone];
        copy.content = [self.content copyWithZone:zone];
    }
    
    return copy;
}


@end
