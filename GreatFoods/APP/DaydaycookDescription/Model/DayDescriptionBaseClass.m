//
//  DayDescriptionBaseClass.m
//
//  Created by 浩文 夏 on 16/4/19
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "DayDescriptionBaseClass.h"
#import "DayDescriptionData.h"


NSString *const kDayDescriptionBaseClassMsg = @"msg";
NSString *const kDayDescriptionBaseClassData = @"data";
NSString *const kDayDescriptionBaseClassCode = @"code";


@interface DayDescriptionBaseClass ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation DayDescriptionBaseClass

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
            self.msg = [self objectOrNilForKey:kDayDescriptionBaseClassMsg fromDictionary:dict];
            self.data = [DayDescriptionData modelObjectWithDictionary:[dict objectForKey:kDayDescriptionBaseClassData]];
            self.code = [self objectOrNilForKey:kDayDescriptionBaseClassCode fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.msg forKey:kDayDescriptionBaseClassMsg];
    [mutableDict setValue:[self.data dictionaryRepresentation] forKey:kDayDescriptionBaseClassData];
    [mutableDict setValue:self.code forKey:kDayDescriptionBaseClassCode];

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

    self.msg = [aDecoder decodeObjectForKey:kDayDescriptionBaseClassMsg];
    self.data = [aDecoder decodeObjectForKey:kDayDescriptionBaseClassData];
    self.code = [aDecoder decodeObjectForKey:kDayDescriptionBaseClassCode];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_msg forKey:kDayDescriptionBaseClassMsg];
    [aCoder encodeObject:_data forKey:kDayDescriptionBaseClassData];
    [aCoder encodeObject:_code forKey:kDayDescriptionBaseClassCode];
}

- (id)copyWithZone:(NSZone *)zone
{
    DayDescriptionBaseClass *copy = [[DayDescriptionBaseClass alloc] init];
    
    if (copy) {

        copy.msg = [self.msg copyWithZone:zone];
        copy.data = [self.data copyWithZone:zone];
        copy.code = [self.code copyWithZone:zone];
    }
    
    return copy;
}


@end
