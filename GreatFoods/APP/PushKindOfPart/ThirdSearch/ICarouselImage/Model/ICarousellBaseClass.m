//
//  ICarousellBaseClass.m
//
//  Created by 浩文 夏 on 16/4/25
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "ICarousellBaseClass.h"
#import "ICarousellData.h"


NSString *const kICarousellBaseClassMsg = @"msg";
NSString *const kICarousellBaseClassData = @"data";
NSString *const kICarousellBaseClassCode = @"code";


@interface ICarousellBaseClass ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ICarousellBaseClass

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
            self.msg = [self objectOrNilForKey:kICarousellBaseClassMsg fromDictionary:dict];
    NSObject *receivedICarousellData = [dict objectForKey:kICarousellBaseClassData];
    NSMutableArray *parsedICarousellData = [NSMutableArray array];
    if ([receivedICarousellData isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedICarousellData) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedICarousellData addObject:[ICarousellData modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedICarousellData isKindOfClass:[NSDictionary class]]) {
       [parsedICarousellData addObject:[ICarousellData modelObjectWithDictionary:(NSDictionary *)receivedICarousellData]];
    }

    self.data = [NSArray arrayWithArray:parsedICarousellData];
            self.code = [self objectOrNilForKey:kICarousellBaseClassCode fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.msg forKey:kICarousellBaseClassMsg];
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
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForData] forKey:kICarousellBaseClassData];
    [mutableDict setValue:self.code forKey:kICarousellBaseClassCode];

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

    self.msg = [aDecoder decodeObjectForKey:kICarousellBaseClassMsg];
    self.data = [aDecoder decodeObjectForKey:kICarousellBaseClassData];
    self.code = [aDecoder decodeObjectForKey:kICarousellBaseClassCode];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_msg forKey:kICarousellBaseClassMsg];
    [aCoder encodeObject:_data forKey:kICarousellBaseClassData];
    [aCoder encodeObject:_code forKey:kICarousellBaseClassCode];
}

- (id)copyWithZone:(NSZone *)zone
{
    ICarousellBaseClass *copy = [[ICarousellBaseClass alloc] init];
    
    if (copy) {

        copy.msg = [self.msg copyWithZone:zone];
        copy.data = [self.data copyWithZone:zone];
        copy.code = [self.code copyWithZone:zone];
    }
    
    return copy;
}


@end
