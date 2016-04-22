//
//  List.m
//
//  Created by lanou  on 16/4/22
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "List.h"


NSString *const kListCommentCount = @"commentCount";
NSString *const kListId = @"id";
NSString *const kListImageid = @"imageid";
NSString *const kListAuthorid = @"authorid";
NSString *const kListAuthorname = @"authorname";
NSString *const kListAuthorimageid = @"authorimageid";
NSString *const kListCollectCount = @"collectCount";
NSString *const kListType = @"type";
NSString *const kListDescription = @"description";
NSString *const kListName = @"name";
NSString *const kListLikeCount = @"likeCount";


@interface List ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation List

@synthesize commentCount = _commentCount;
@synthesize listIdentifier = _listIdentifier;
@synthesize imageid = _imageid;
@synthesize authorid = _authorid;
@synthesize authorname = _authorname;
@synthesize authorimageid = _authorimageid;
@synthesize collectCount = _collectCount;
@synthesize type = _type;
@synthesize listDescription = _listDescription;
@synthesize name = _name;
@synthesize likeCount = _likeCount;


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
            self.commentCount = [self objectOrNilForKey:kListCommentCount fromDictionary:dict];
            self.listIdentifier = [self objectOrNilForKey:kListId fromDictionary:dict];
            self.imageid = [self objectOrNilForKey:kListImageid fromDictionary:dict];
            self.authorid = [self objectOrNilForKey:kListAuthorid fromDictionary:dict];
            self.authorname = [self objectOrNilForKey:kListAuthorname fromDictionary:dict];
            self.authorimageid = [self objectOrNilForKey:kListAuthorimageid fromDictionary:dict];
            self.collectCount = [self objectOrNilForKey:kListCollectCount fromDictionary:dict];
            self.type = [self objectOrNilForKey:kListType fromDictionary:dict];
            self.listDescription = [self objectOrNilForKey:kListDescription fromDictionary:dict];
            self.name = [self objectOrNilForKey:kListName fromDictionary:dict];
            self.likeCount = [self objectOrNilForKey:kListLikeCount fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.commentCount forKey:kListCommentCount];
    [mutableDict setValue:self.listIdentifier forKey:kListId];
    [mutableDict setValue:self.imageid forKey:kListImageid];
    [mutableDict setValue:self.authorid forKey:kListAuthorid];
    [mutableDict setValue:self.authorname forKey:kListAuthorname];
    [mutableDict setValue:self.authorimageid forKey:kListAuthorimageid];
    [mutableDict setValue:self.collectCount forKey:kListCollectCount];
    [mutableDict setValue:self.type forKey:kListType];
    [mutableDict setValue:self.listDescription forKey:kListDescription];
    [mutableDict setValue:self.name forKey:kListName];
    [mutableDict setValue:self.likeCount forKey:kListLikeCount];

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

    self.commentCount = [aDecoder decodeObjectForKey:kListCommentCount];
    self.listIdentifier = [aDecoder decodeObjectForKey:kListId];
    self.imageid = [aDecoder decodeObjectForKey:kListImageid];
    self.authorid = [aDecoder decodeObjectForKey:kListAuthorid];
    self.authorname = [aDecoder decodeObjectForKey:kListAuthorname];
    self.authorimageid = [aDecoder decodeObjectForKey:kListAuthorimageid];
    self.collectCount = [aDecoder decodeObjectForKey:kListCollectCount];
    self.type = [aDecoder decodeObjectForKey:kListType];
    self.listDescription = [aDecoder decodeObjectForKey:kListDescription];
    self.name = [aDecoder decodeObjectForKey:kListName];
    self.likeCount = [aDecoder decodeObjectForKey:kListLikeCount];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_commentCount forKey:kListCommentCount];
    [aCoder encodeObject:_listIdentifier forKey:kListId];
    [aCoder encodeObject:_imageid forKey:kListImageid];
    [aCoder encodeObject:_authorid forKey:kListAuthorid];
    [aCoder encodeObject:_authorname forKey:kListAuthorname];
    [aCoder encodeObject:_authorimageid forKey:kListAuthorimageid];
    [aCoder encodeObject:_collectCount forKey:kListCollectCount];
    [aCoder encodeObject:_type forKey:kListType];
    [aCoder encodeObject:_listDescription forKey:kListDescription];
    [aCoder encodeObject:_name forKey:kListName];
    [aCoder encodeObject:_likeCount forKey:kListLikeCount];
}

- (id)copyWithZone:(NSZone *)zone
{
    List *copy = [[List alloc] init];
    
    if (copy) {

        copy.commentCount = [self.commentCount copyWithZone:zone];
        copy.listIdentifier = [self.listIdentifier copyWithZone:zone];
        copy.imageid = [self.imageid copyWithZone:zone];
        copy.authorid = [self.authorid copyWithZone:zone];
        copy.authorname = [self.authorname copyWithZone:zone];
        copy.authorimageid = [self.authorimageid copyWithZone:zone];
        copy.collectCount = [self.collectCount copyWithZone:zone];
        copy.type = [self.type copyWithZone:zone];
        copy.listDescription = [self.listDescription copyWithZone:zone];
        copy.name = [self.name copyWithZone:zone];
        copy.likeCount = [self.likeCount copyWithZone:zone];
    }
    
    return copy;
}


@end
