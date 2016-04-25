//
//  SearchBase.m
//
//  Created by 浩文 夏 on 16/4/22
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "SearchBase.h"
#import "SearchData.h"


NSString *const kSearchBaseMsg = @"msg";
NSString *const kSearchBaseData = @"data";
NSString *const kSearchBaseCode = @"code";


@interface SearchBase ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation SearchBase

@synthesize msg = _msg;
@synthesize data = _data;
@synthesize code = _code;


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
            self.msg = [self objectOrNilForKey:kSearchBaseMsg fromDictionary:dict];
    NSObject *receivedSearchData = [dict objectForKey:kSearchBaseData];
    NSMutableArray *parsedSearchData = [NSMutableArray array];
    if ([receivedSearchData isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedSearchData) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedSearchData addObject:[SearchData modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedSearchData isKindOfClass:[NSDictionary class]]) {
       [parsedSearchData addObject:[SearchData modelObjectWithDictionary:(NSDictionary *)receivedSearchData]];
    }

    self.data = [NSArray arrayWithArray:parsedSearchData];
            self.code = [self objectOrNilForKey:kSearchBaseCode fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.msg forKey:kSearchBaseMsg];
    NSMutableArray *tempArrayForData = [NSMutableArray array];
    for (NSObject *subArrayObject in self.data) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForData addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForData addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForData] forKey:kSearchBaseData];
    [mutableDict setValue:self.code forKey:kSearchBaseCode];

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

    self.msg = [aDecoder decodeObjectForKey:kSearchBaseMsg];
    self.data = [aDecoder decodeObjectForKey:kSearchBaseData];
    self.code = [aDecoder decodeObjectForKey:kSearchBaseCode];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_msg forKey:kSearchBaseMsg];
    [aCoder encodeObject:_data forKey:kSearchBaseData];
    [aCoder encodeObject:_code forKey:kSearchBaseCode];
}

- (id)copyWithZone:(NSZone *)zone
{
    SearchBase *copy = [[SearchBase alloc] init];
    
    if (copy) {

        copy.msg = [self.msg copyWithZone:zone];
        copy.data = [self.data copyWithZone:zone];
        copy.code = [self.code copyWithZone:zone];
    }
    
    return copy;
}


@end
