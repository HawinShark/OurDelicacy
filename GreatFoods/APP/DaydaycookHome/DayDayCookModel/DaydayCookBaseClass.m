//
//  DaydayCookBaseClass.m
//
//  Created by 浩文 夏 on 16/4/19
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "DaydayCookBaseClass.h"
#import "DaydayCookData.h"


NSString *const kDaydayCookBaseClassMsg = @"msg";
NSString *const kDaydayCookBaseClassData = @"data";
NSString *const kDaydayCookBaseClassCode = @"code";


@interface DaydayCookBaseClass ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation DaydayCookBaseClass

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
            self.msg = [self objectOrNilForKey:kDaydayCookBaseClassMsg fromDictionary:dict];
    NSObject *receivedDaydayCookData = [dict objectForKey:kDaydayCookBaseClassData];
    NSMutableArray *parsedDaydayCookData = [NSMutableArray array];
    if ([receivedDaydayCookData isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedDaydayCookData) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedDaydayCookData addObject:[DaydayCookData modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedDaydayCookData isKindOfClass:[NSDictionary class]]) {
       [parsedDaydayCookData addObject:[DaydayCookData modelObjectWithDictionary:(NSDictionary *)receivedDaydayCookData]];
    }

    self.data = [NSArray arrayWithArray:parsedDaydayCookData];
            self.code = [self objectOrNilForKey:kDaydayCookBaseClassCode fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.msg forKey:kDaydayCookBaseClassMsg];
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
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForData] forKey:kDaydayCookBaseClassData];
    [mutableDict setValue:self.code forKey:kDaydayCookBaseClassCode];

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

    self.msg = [aDecoder decodeObjectForKey:kDaydayCookBaseClassMsg];
    self.data = [aDecoder decodeObjectForKey:kDaydayCookBaseClassData];
    self.code = [aDecoder decodeObjectForKey:kDaydayCookBaseClassCode];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_msg forKey:kDaydayCookBaseClassMsg];
    [aCoder encodeObject:_data forKey:kDaydayCookBaseClassData];
    [aCoder encodeObject:_code forKey:kDaydayCookBaseClassCode];
}

- (id)copyWithZone:(NSZone *)zone
{
    DaydayCookBaseClass *copy = [[DaydayCookBaseClass alloc] init];
    
    if (copy) {

        copy.msg = [self.msg copyWithZone:zone];
        copy.data = [self.data copyWithZone:zone];
        copy.code = [self.code copyWithZone:zone];
    }
    
    return copy;
}


@end
