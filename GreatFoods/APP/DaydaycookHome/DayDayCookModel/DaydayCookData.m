//
//  DaydayCookData.m
//
//  Created by 浩文 夏 on 16/4/19
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "DaydayCookData.h"



NSString *const kDaydayCookDataClickCount = @"clickCount";
NSString *const kDaydayCookDataDetailsUrl = @"detailsUrl";
NSString *const kDaydayCookDataDifficulty = @"difficulty";
NSString *const kDaydayCookDataId = @"id";
NSString *const kDaydayCookDataImageUrlFlow = @"imageUrlFlow";
NSString *const kDaydayCookDataCategory = @"category";
NSString *const kDaydayCookDataCategoryID = @"categoryID";
NSString *const kDaydayCookDataLable = @"lable";
NSString *const kDaydayCookDataTaste = @"taste";
NSString *const kDaydayCookDataDeleteStatus = @"deleteStatus";
NSString *const kDaydayCookDataScreList = @"screList";
NSString *const kDaydayCookDataDescription = @"description";
NSString *const kDaydayCookDataTechnology = @"technology";
NSString *const kDaydayCookDataType = @"type";
NSString *const kDaydayCookDataReleaseDate = @"releaseDate";
NSString *const kDaydayCookDataPeopleEat = @"peopleEat";
NSString *const kDaydayCookDataLoadContent = @"loadContent";
NSString *const kDaydayCookDataScreeningId = @"screeningId";
NSString *const kDaydayCookDataArea = @"area";
NSString *const kDaydayCookDataIndexUrl = @"indexUrl";
NSString *const kDaydayCookDataImageHeight = @"imageHeight";
NSString *const kDaydayCookDataParentCategoryId = @"parentCategoryId";
NSString *const kDaydayCookDataShareUrl = @"shareUrl";
NSString *const kDaydayCookDataMaketime = @"maketime";
NSString *const kDaydayCookDataPageInfo = @"pageInfo";
NSString *const kDaydayCookDataName = @"name";
NSString *const kDaydayCookDataShareCount = @"shareCount";
NSString *const kDaydayCookDataFavorite = @"favorite";
NSString *const kDaydayCookDataReleasePlat = @"releasePlat";
NSString *const kDaydayCookDataCreateDate = @"createDate";
NSString *const kDaydayCookDataContent = @"content";
NSString *const kDaydayCookDataModifyDate = @"modifyDate";
NSString *const kDaydayCookDataImageWidth = @"imageWidth";
NSString *const kDaydayCookDataImageUrl = @"imageUrl";
NSString *const kDaydayCookDataTitle = @"title";
NSString *const kDaydayCookDataDisplayState = @"displayState";


@interface DaydayCookData ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation DaydayCookData

@synthesize clickCount = _clickCount;
@synthesize detailsUrl = _detailsUrl;
@synthesize difficulty = _difficulty;
@synthesize dataIdentifier = _dataIdentifier;
@synthesize imageUrlFlow = _imageUrlFlow;
@synthesize category = _category;
@synthesize categoryID = _categoryID;
@synthesize lable = _lable;
@synthesize taste = _taste;
@synthesize deleteStatus = _deleteStatus;
@synthesize screList = _screList;
@synthesize dataDescription = _dataDescription;
@synthesize technology = _technology;
@synthesize type = _type;
@synthesize releaseDate = _releaseDate;
@synthesize peopleEat = _peopleEat;
@synthesize loadContent = _loadContent;
@synthesize screeningId = _screeningId;
@synthesize area = _area;
@synthesize indexUrl = _indexUrl;
@synthesize imageHeight = _imageHeight;
@synthesize parentCategoryId = _parentCategoryId;
@synthesize shareUrl = _shareUrl;
@synthesize maketime = _maketime;
@synthesize pageInfo = _pageInfo;
@synthesize name = _name;
@synthesize shareCount = _shareCount;
@synthesize favorite = _favorite;
@synthesize releasePlat = _releasePlat;
@synthesize createDate = _createDate;
@synthesize content = _content;
@synthesize modifyDate = _modifyDate;
@synthesize imageWidth = _imageWidth;
@synthesize imageUrl = _imageUrl;
@synthesize title = _title;
@synthesize displayState = _displayState;


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
            self.clickCount = [[self objectOrNilForKey:kDaydayCookDataClickCount fromDictionary:dict] doubleValue];
            self.detailsUrl = [self objectOrNilForKey:kDaydayCookDataDetailsUrl fromDictionary:dict];
            self.difficulty = [self objectOrNilForKey:kDaydayCookDataDifficulty fromDictionary:dict];
            self.dataIdentifier = [[self objectOrNilForKey:kDaydayCookDataId fromDictionary:dict] doubleValue];
            self.imageUrlFlow = [self objectOrNilForKey:kDaydayCookDataImageUrlFlow fromDictionary:dict];
            self.category = [self objectOrNilForKey:kDaydayCookDataCategory fromDictionary:dict];
            self.categoryID = [self objectOrNilForKey:kDaydayCookDataCategoryID fromDictionary:dict];
            self.lable = [self objectOrNilForKey:kDaydayCookDataLable fromDictionary:dict];
            self.taste = [self objectOrNilForKey:kDaydayCookDataTaste fromDictionary:dict];
            self.deleteStatus = [[self objectOrNilForKey:kDaydayCookDataDeleteStatus fromDictionary:dict] doubleValue];
            self.screList = [self objectOrNilForKey:kDaydayCookDataScreList fromDictionary:dict];
            self.dataDescription = [self objectOrNilForKey:kDaydayCookDataDescription fromDictionary:dict];
            self.technology = [self objectOrNilForKey:kDaydayCookDataTechnology fromDictionary:dict];
            self.type = [self objectOrNilForKey:kDaydayCookDataType fromDictionary:dict];
            self.releaseDate = [self objectOrNilForKey:kDaydayCookDataReleaseDate fromDictionary:dict];
            self.peopleEat = [self objectOrNilForKey:kDaydayCookDataPeopleEat fromDictionary:dict];
            self.loadContent = [self objectOrNilForKey:kDaydayCookDataLoadContent fromDictionary:dict];
            self.screeningId = [self objectOrNilForKey:kDaydayCookDataScreeningId fromDictionary:dict];
            self.area = [self objectOrNilForKey:kDaydayCookDataArea fromDictionary:dict];
            self.indexUrl = [self objectOrNilForKey:kDaydayCookDataIndexUrl fromDictionary:dict];
            self.imageHeight = [self objectOrNilForKey:kDaydayCookDataImageHeight fromDictionary:dict];
            self.parentCategoryId = [self objectOrNilForKey:kDaydayCookDataParentCategoryId fromDictionary:dict];
            self.shareUrl = [self objectOrNilForKey:kDaydayCookDataShareUrl fromDictionary:dict];
            self.maketime = [self objectOrNilForKey:kDaydayCookDataMaketime fromDictionary:dict];
            self.pageInfo = [self objectOrNilForKey:kDaydayCookDataPageInfo fromDictionary:dict];
            self.name = [self objectOrNilForKey:kDaydayCookDataName fromDictionary:dict];
            self.shareCount = [[self objectOrNilForKey:kDaydayCookDataShareCount fromDictionary:dict] doubleValue];
            self.favorite = [[self objectOrNilForKey:kDaydayCookDataFavorite fromDictionary:dict] boolValue];
            self.releasePlat = [self objectOrNilForKey:kDaydayCookDataReleasePlat fromDictionary:dict];
            self.createDate = [[self objectOrNilForKey:kDaydayCookDataCreateDate fromDictionary:dict] doubleValue];
            self.content = [self objectOrNilForKey:kDaydayCookDataContent fromDictionary:dict];
            self.modifyDate = [[self objectOrNilForKey:kDaydayCookDataModifyDate fromDictionary:dict] doubleValue];
            self.imageWidth = [self objectOrNilForKey:kDaydayCookDataImageWidth fromDictionary:dict];
            self.imageUrl = [self objectOrNilForKey:kDaydayCookDataImageUrl fromDictionary:dict];
            self.title = [self objectOrNilForKey:kDaydayCookDataTitle fromDictionary:dict];
            self.displayState = [self objectOrNilForKey:kDaydayCookDataDisplayState fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.clickCount] forKey:kDaydayCookDataClickCount];
    [mutableDict setValue:self.detailsUrl forKey:kDaydayCookDataDetailsUrl];
    [mutableDict setValue:self.difficulty forKey:kDaydayCookDataDifficulty];
    [mutableDict setValue:[NSNumber numberWithDouble:self.dataIdentifier] forKey:kDaydayCookDataId];
    [mutableDict setValue:self.imageUrlFlow forKey:kDaydayCookDataImageUrlFlow];
    [mutableDict setValue:self.category forKey:kDaydayCookDataCategory];
    [mutableDict setValue:self.categoryID forKey:kDaydayCookDataCategoryID];
    [mutableDict setValue:self.lable forKey:kDaydayCookDataLable];
    [mutableDict setValue:self.taste forKey:kDaydayCookDataTaste];
    [mutableDict setValue:[NSNumber numberWithDouble:self.deleteStatus] forKey:kDaydayCookDataDeleteStatus];
    NSMutableArray *tempArrayForScreList = [NSMutableArray array];
    for (NSObject *subArrayObject in self.screList) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForScreList addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForScreList addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForScreList] forKey:kDaydayCookDataScreList];
    [mutableDict setValue:self.dataDescription forKey:kDaydayCookDataDescription];
    [mutableDict setValue:self.technology forKey:kDaydayCookDataTechnology];
    [mutableDict setValue:self.type forKey:kDaydayCookDataType];
    [mutableDict setValue:self.releaseDate forKey:kDaydayCookDataReleaseDate];
    [mutableDict setValue:self.peopleEat forKey:kDaydayCookDataPeopleEat];
    [mutableDict setValue:self.loadContent forKey:kDaydayCookDataLoadContent];
    [mutableDict setValue:self.screeningId forKey:kDaydayCookDataScreeningId];
    [mutableDict setValue:self.area forKey:kDaydayCookDataArea];
    [mutableDict setValue:self.indexUrl forKey:kDaydayCookDataIndexUrl];
    [mutableDict setValue:self.imageHeight forKey:kDaydayCookDataImageHeight];
    [mutableDict setValue:self.parentCategoryId forKey:kDaydayCookDataParentCategoryId];
    [mutableDict setValue:self.shareUrl forKey:kDaydayCookDataShareUrl];
    [mutableDict setValue:self.maketime forKey:kDaydayCookDataMaketime];
    [mutableDict setValue:self.pageInfo forKey:kDaydayCookDataPageInfo];
    [mutableDict setValue:self.name forKey:kDaydayCookDataName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.shareCount] forKey:kDaydayCookDataShareCount];
    [mutableDict setValue:[NSNumber numberWithBool:self.favorite] forKey:kDaydayCookDataFavorite];
    [mutableDict setValue:self.releasePlat forKey:kDaydayCookDataReleasePlat];
    [mutableDict setValue:[NSNumber numberWithDouble:self.createDate] forKey:kDaydayCookDataCreateDate];
    [mutableDict setValue:self.content forKey:kDaydayCookDataContent];
    [mutableDict setValue:[NSNumber numberWithDouble:self.modifyDate] forKey:kDaydayCookDataModifyDate];
    [mutableDict setValue:self.imageWidth forKey:kDaydayCookDataImageWidth];
    [mutableDict setValue:self.imageUrl forKey:kDaydayCookDataImageUrl];
    [mutableDict setValue:self.title forKey:kDaydayCookDataTitle];
    [mutableDict setValue:self.displayState forKey:kDaydayCookDataDisplayState];

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

    self.clickCount = [aDecoder decodeDoubleForKey:kDaydayCookDataClickCount];
    self.detailsUrl = [aDecoder decodeObjectForKey:kDaydayCookDataDetailsUrl];
    self.difficulty = [aDecoder decodeObjectForKey:kDaydayCookDataDifficulty];
    self.dataIdentifier = [aDecoder decodeDoubleForKey:kDaydayCookDataId];
    self.imageUrlFlow = [aDecoder decodeObjectForKey:kDaydayCookDataImageUrlFlow];
    self.category = [aDecoder decodeObjectForKey:kDaydayCookDataCategory];
    self.categoryID = [aDecoder decodeObjectForKey:kDaydayCookDataCategoryID];
    self.lable = [aDecoder decodeObjectForKey:kDaydayCookDataLable];
    self.taste = [aDecoder decodeObjectForKey:kDaydayCookDataTaste];
    self.deleteStatus = [aDecoder decodeDoubleForKey:kDaydayCookDataDeleteStatus];
    self.screList = [aDecoder decodeObjectForKey:kDaydayCookDataScreList];
    self.dataDescription = [aDecoder decodeObjectForKey:kDaydayCookDataDescription];
    self.technology = [aDecoder decodeObjectForKey:kDaydayCookDataTechnology];
    self.type = [aDecoder decodeObjectForKey:kDaydayCookDataType];
    self.releaseDate = [aDecoder decodeObjectForKey:kDaydayCookDataReleaseDate];
    self.peopleEat = [aDecoder decodeObjectForKey:kDaydayCookDataPeopleEat];
    self.loadContent = [aDecoder decodeObjectForKey:kDaydayCookDataLoadContent];
    self.screeningId = [aDecoder decodeObjectForKey:kDaydayCookDataScreeningId];
    self.area = [aDecoder decodeObjectForKey:kDaydayCookDataArea];
    self.indexUrl = [aDecoder decodeObjectForKey:kDaydayCookDataIndexUrl];
    self.imageHeight = [aDecoder decodeObjectForKey:kDaydayCookDataImageHeight];
    self.parentCategoryId = [aDecoder decodeObjectForKey:kDaydayCookDataParentCategoryId];
    self.shareUrl = [aDecoder decodeObjectForKey:kDaydayCookDataShareUrl];
    self.maketime = [aDecoder decodeObjectForKey:kDaydayCookDataMaketime];
    self.pageInfo = [aDecoder decodeObjectForKey:kDaydayCookDataPageInfo];
    self.name = [aDecoder decodeObjectForKey:kDaydayCookDataName];
    self.shareCount = [aDecoder decodeDoubleForKey:kDaydayCookDataShareCount];
    self.favorite = [aDecoder decodeBoolForKey:kDaydayCookDataFavorite];
    self.releasePlat = [aDecoder decodeObjectForKey:kDaydayCookDataReleasePlat];
    self.createDate = [aDecoder decodeDoubleForKey:kDaydayCookDataCreateDate];
    self.content = [aDecoder decodeObjectForKey:kDaydayCookDataContent];
    self.modifyDate = [aDecoder decodeDoubleForKey:kDaydayCookDataModifyDate];
    self.imageWidth = [aDecoder decodeObjectForKey:kDaydayCookDataImageWidth];
    self.imageUrl = [aDecoder decodeObjectForKey:kDaydayCookDataImageUrl];
    self.title = [aDecoder decodeObjectForKey:kDaydayCookDataTitle];
    self.displayState = [aDecoder decodeObjectForKey:kDaydayCookDataDisplayState];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_clickCount forKey:kDaydayCookDataClickCount];
    [aCoder encodeObject:_detailsUrl forKey:kDaydayCookDataDetailsUrl];
    [aCoder encodeObject:_difficulty forKey:kDaydayCookDataDifficulty];
    [aCoder encodeDouble:_dataIdentifier forKey:kDaydayCookDataId];
    [aCoder encodeObject:_imageUrlFlow forKey:kDaydayCookDataImageUrlFlow];
    [aCoder encodeObject:_category forKey:kDaydayCookDataCategory];
    [aCoder encodeObject:_categoryID forKey:kDaydayCookDataCategoryID];
    [aCoder encodeObject:_lable forKey:kDaydayCookDataLable];
    [aCoder encodeObject:_taste forKey:kDaydayCookDataTaste];
    [aCoder encodeDouble:_deleteStatus forKey:kDaydayCookDataDeleteStatus];
    [aCoder encodeObject:_screList forKey:kDaydayCookDataScreList];
    [aCoder encodeObject:_dataDescription forKey:kDaydayCookDataDescription];
    [aCoder encodeObject:_technology forKey:kDaydayCookDataTechnology];
    [aCoder encodeObject:_type forKey:kDaydayCookDataType];
    [aCoder encodeObject:_releaseDate forKey:kDaydayCookDataReleaseDate];
    [aCoder encodeObject:_peopleEat forKey:kDaydayCookDataPeopleEat];
    [aCoder encodeObject:_loadContent forKey:kDaydayCookDataLoadContent];
    [aCoder encodeObject:_screeningId forKey:kDaydayCookDataScreeningId];
    [aCoder encodeObject:_area forKey:kDaydayCookDataArea];
    [aCoder encodeObject:_indexUrl forKey:kDaydayCookDataIndexUrl];
    [aCoder encodeObject:_imageHeight forKey:kDaydayCookDataImageHeight];
    [aCoder encodeObject:_parentCategoryId forKey:kDaydayCookDataParentCategoryId];
    [aCoder encodeObject:_shareUrl forKey:kDaydayCookDataShareUrl];
    [aCoder encodeObject:_maketime forKey:kDaydayCookDataMaketime];
    [aCoder encodeObject:_pageInfo forKey:kDaydayCookDataPageInfo];
    [aCoder encodeObject:_name forKey:kDaydayCookDataName];
    [aCoder encodeDouble:_shareCount forKey:kDaydayCookDataShareCount];
    [aCoder encodeBool:_favorite forKey:kDaydayCookDataFavorite];
    [aCoder encodeObject:_releasePlat forKey:kDaydayCookDataReleasePlat];
    [aCoder encodeDouble:_createDate forKey:kDaydayCookDataCreateDate];
    [aCoder encodeObject:_content forKey:kDaydayCookDataContent];
    [aCoder encodeDouble:_modifyDate forKey:kDaydayCookDataModifyDate];
    [aCoder encodeObject:_imageWidth forKey:kDaydayCookDataImageWidth];
    [aCoder encodeObject:_imageUrl forKey:kDaydayCookDataImageUrl];
    [aCoder encodeObject:_title forKey:kDaydayCookDataTitle];
    [aCoder encodeObject:_displayState forKey:kDaydayCookDataDisplayState];
}



- (id)copyWithZone:(NSZone *)zone
{
    DaydayCookData *copy = [[DaydayCookData alloc] init];
    
    if (copy) {

        copy.clickCount = self.clickCount;
        copy.detailsUrl = [self.detailsUrl copyWithZone:zone];
        copy.difficulty = [self.difficulty copyWithZone:zone];
        copy.dataIdentifier = self.dataIdentifier;
        copy.imageUrlFlow = [self.imageUrlFlow copyWithZone:zone];
        copy.category = [self.category copyWithZone:zone];
        copy.categoryID = [self.categoryID copyWithZone:zone];
        copy.lable = [self.lable copyWithZone:zone];
        copy.taste = [self.taste copyWithZone:zone];
        copy.deleteStatus = self.deleteStatus;
        copy.screList = [self.screList copyWithZone:zone];
        copy.dataDescription = [self.dataDescription copyWithZone:zone];
        copy.technology = [self.technology copyWithZone:zone];
        copy.type = [self.type copyWithZone:zone];
        copy.releaseDate = [self.releaseDate copyWithZone:zone];
        copy.peopleEat = [self.peopleEat copyWithZone:zone];
        copy.loadContent = [self.loadContent copyWithZone:zone];
        copy.screeningId = [self.screeningId copyWithZone:zone];
        copy.area = [self.area copyWithZone:zone];
        copy.indexUrl = [self.indexUrl copyWithZone:zone];
        copy.imageHeight = [self.imageHeight copyWithZone:zone];
        copy.parentCategoryId = [self.parentCategoryId copyWithZone:zone];
        copy.shareUrl = [self.shareUrl copyWithZone:zone];
        copy.maketime = [self.maketime copyWithZone:zone];
        copy.pageInfo = [self.pageInfo copyWithZone:zone];
        copy.name = [self.name copyWithZone:zone];
        copy.shareCount = self.shareCount;
        copy.favorite = self.favorite;
        copy.releasePlat = [self.releasePlat copyWithZone:zone];
        copy.createDate = self.createDate;
        copy.content = [self.content copyWithZone:zone];
        copy.modifyDate = self.modifyDate;
        copy.imageWidth = [self.imageWidth copyWithZone:zone];
        copy.imageUrl = [self.imageUrl copyWithZone:zone];
        copy.title = [self.title copyWithZone:zone];
        copy.displayState = [self.displayState copyWithZone:zone];
    }
    
    return copy;
}


@end
